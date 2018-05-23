From: davem@davemloft.net (David Miller)
Date: Wed, 23 May 2018 15:27:17 -0400 (EDT)
Subject: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
In-Reply-To: <20180523000450.9384-1-f.fainelli@gmail.com>
References: <20180523000450.9384-1-f.fainelli@gmail.com>
Message-ID: <20180523.152717.320840011665325518.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 22 May 2018 17:04:49 -0700

> On newer PHYs, we need to select the expansion register to write with
> setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
> to being migrated to generic code under bcm-phy-lib.c which
> unfortunately used the older implementation from the BCM54xx days.
> 
> Fix this by creating an inline stub: bcm_write_exp_sel() which adds the
> correct value (MII_BCM54XX_EXP_SEL_ER) and update both the Cygnus PHY
> and BCM7xxx PHY drivers which require setting these bits.
> 
> broadcom.c is unchanged because some PHYs even use a different selector
> method, so let them specify it directly (e.g: SerDes secondary selector).
> 
> Fixes: a1cba5613edf ("net: phy: Add Broadcom phy library for common interfaces")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> David, please also queue this one up for -stable, thanks!

Applied and queued up for -stable, thanks Florian.
