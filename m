From: davem@davemloft.net (David Miller)
Date: Mon, 04 Mar 2013 14:15:44 -0500 (EST)
Subject: [PATCH 1/1] net: fec: fix build error in no MXC platform
In-Reply-To: <1362379958-12972-1-git-send-email-Frank.Li@freescale.com>
References: <1362379958-12972-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130304.141544.1354907717393768867.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Mon, 4 Mar 2013 14:52:38 +0800

> build error cause by
> Commit ff43da86c69d76a726ffe7d1666148960dc1d108
> ("NET: FEC: dynamtic check DMA desc buff type")
> 
> drivers/net/ethernet/freescale/fec.c: In function ?fec_enet_get_nextdesc?:
> drivers/net/ethernet/freescale/fec.c:215:18: error: invalid use of undefined type ?struct bufdesc_ex?
> drivers/net/ethernet/freescale/fec.c: In function ?fec_enet_get_prevdesc?:
> drivers/net/ethernet/freescale/fec.c:224:18: error: invalid use of undefined type ?struct bufdesc_ex?
> drivers/net/ethernet/freescale/fec.c: In function ?fec_enet_start_xmit?:
> drivers/net/ethernet/freescale/fec.c:286:37: error: arithmetic on pointer to an incomplete type
> drivers/net/ethernet/freescale/fec.c:287:13: error: arithmetic on pointer to an incomplete type
> drivers/net/ethernet/freescale/fec.c:324:7: error: dereferencing pointer to incomplete type etc....
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied.
