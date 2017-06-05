From: davem@davemloft.net (David Miller)
Date: Mon, 05 Jun 2017 11:23:37 -0400 (EDT)
Subject: [PATCH] net-next: stmmac: dwmac-sun8i: ensure the EPHY is
 properly reseted
In-Reply-To: <20170604175323.62124-1-icenowy@aosc.io>
References: <20170604175323.62124-1-icenowy@aosc.io>
Message-ID: <20170605.112337.1925463603967545555.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>
Date: Mon,  5 Jun 2017 01:53:23 +0800

> The EPHY may be already enabled by bootloaders which have Ethernet
> capability (e.g. current U-Boot). Thus it should be reseted properly
> before doing the enabling sequence in the dwmac-sun8i driver, otherwise
> the EMAC reset process may fail if no cable is plugged, and then fail
> the dwmac-sun8i probing.
> 
> Tested on Orange Pi PC, One and Zero. All the boards fail to have
> dwmac-sun8i probed with "EMAC reset timeout" without cable plugged
> before, and with this fix they're now all able to successfully probe the
> EMAC without cable plugged and then use the connection after a cable is
> hot-plugged in.
> 
> Fixes: 9f93ac8d408 ("net-next: stmmac: Add dwmac-sun8i")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks.
