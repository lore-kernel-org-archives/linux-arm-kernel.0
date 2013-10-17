From: davem@davemloft.net (David Miller)
Date: Thu, 17 Oct 2013 15:48:44 -0400 (EDT)
Subject: [PATCH] net/ethernet: cpsw: Bugfix interrupts before enabling napi
In-Reply-To: <1381691821-25498-1-git-send-email-mpa@pengutronix.de>
References: <1381691821-25498-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131017.154844.1958017973482686300.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutronix.de>
Date: Sun, 13 Oct 2013 21:17:01 +0200

> If interrupts happen before napi_enable was called, the driver will not
> work as expected. Network transmissions are impossible in this state.
> This bug can be reproduced easily by restarting the network interface in
> a loop. After some time any network transmissions on the network
> interface will fail.
> 
> This patch fixes the bug by enabling napi before enabling the network
> interface interrupts.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied, thanks.
