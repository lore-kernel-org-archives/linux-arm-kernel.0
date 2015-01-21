From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 09:32:38 +0100
Subject: [PATCH v2 0/4] net: stmmac: dwmac-rk: Fix phy regulator issues
In-Reply-To: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
References: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1791081.FUojULYATz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 20. Januar 2015, 07:09:36 schrieb Romain Perier:
> This series fixes few issues in dwmac-rk:
> 
> 1. Voltage settings was hardcoded into the driver for the phy regulator.
>    The driver now uses the default voltage settings found in the devicetree,
> which are applied throught the regulator framework.
> 2. The regulator name used to power on or power off the phy was put in the
> devicetree variable "phy_regulator", which is not standard and added a lot
> of code for nothing. The driver now uses the devicetree property
> "phy-supply" and the corresponding functions to manipulate this regulator.
> 
> The corresponding devicetree files are also updated. As this new binding for
> rk3288 has not been released with any official kernel yet (not until 3.20),
> I don't need to care about keeping compatibility with the old non standard
> property.

This series
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@Dave: as said in the v1 mail, this would be nice to have for 3.20
