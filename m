From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jun 2017 16:00:51 +0100
Subject: [PATCH 4/8] ARM: l2x0: add arm,ecc-enable property for aurora
In-Reply-To: <20170630145106.29820-5-jlu@pengutronix.de>
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <20170630145106.29820-5-jlu@pengutronix.de>
Message-ID: <20170630150051.GZ4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 04:51:02PM +0200, Jan Luebbe wrote:
> From: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> The aurora cache on the Marvell Armada-XP SoC supports ECC protection
> for the L2 data arrays. Add a "arm,ecc-enable" device tree property
> which can be used to enable this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> [jlu at pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> index d9650c1788f4..6316e673307a 100644
> --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> @@ -76,6 +76,8 @@ Optional properties:
>    specified to indicate that such transforms are precluded.
>  - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
>  - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
> +- arm,ecc-enable : enable ECC protection on the L2 cache
> +- arm,ecc-disable : disable ECC protection on the L2 cache

Why should this be prefixed by a vendor of "arm" ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
