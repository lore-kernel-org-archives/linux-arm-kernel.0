From: peter@korsgaard.com (Peter Korsgaard)
Date: Mon, 14 Oct 2013 13:48:29 +0200
Subject: [PATCH] net/ethernet: cpsw: Bugfix interrupts before enabling napi
In-Reply-To: <1381691821-25498-1-git-send-email-mpa@pengutronix.de> (Markus
 Pargmann's message of "Sun, 13 Oct 2013 21:17:01 +0200")
References: <1381691821-25498-1-git-send-email-mpa@pengutronix.de>
Message-ID: <8738o4rs36.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Markus" == Markus Pargmann <mpa@pengutronix.de> writes:

 Markus> If interrupts happen before napi_enable was called, the driver will not
 Markus> work as expected. Network transmissions are impossible in this state.
 Markus> This bug can be reproduced easily by restarting the network interface in
 Markus> a loop. After some time any network transmissions on the network
 Markus> interface will fail.

 Markus> This patch fixes the bug by enabling napi before enabling the network
 Markus> interface interrupts.

 Markus> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
