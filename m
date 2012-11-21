From: joe@perches.com (Joe Perches)
Date: Wed, 21 Nov 2012 11:03:56 -0800
Subject: [PATCH 1/1 v2] net: add micrel KSZ8873MLL switch support
In-Reply-To: <1353512287-24048-1-git-send-email-plagnioj@jcrosoft.com>
References: <1353493630-30867-1-git-send-email-plagnioj@jcrosoft.com>
 <1353512287-24048-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353524636.24807.28.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-11-21 at 16:38 +0100, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> this will allow to detect the link between the switch and the soc
[]
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
[]
> @@ -127,6 +127,39 @@ static int ks8051_config_init(struct phy_device *phydev)
[]
> +int ksz8873mll_read_status(struct phy_device *phydev)
> +{
[]
> +	regval = phy_read(phydev, KSZ8873MLL_GLOBAL_CONTROL_4);
> +
> +	if (regval & KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX)
> +		phydev->duplex = DUPLEX_HALF;
> +	else
> +		phydev->duplex = DUPLEX_FULL;

This doesn't check for phy_read errors.
Shouldn't it?
