From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 16 Oct 2013 18:28:36 +0530
Subject: [PATCH] net/ethernet: cpsw: Bugfix interrupts before enabling napi
In-Reply-To: <1381691821-25498-1-git-send-email-mpa@pengutronix.de>
References: <1381691821-25498-1-git-send-email-mpa@pengutronix.de>
Message-ID: <525E8D7C.5050702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 October 2013 12:47 AM, Markus Pargmann wrote:
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
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
