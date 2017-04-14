From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 14 Apr 2017 23:56:39 +0800
Subject: [PATCH 5/8] ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6
 variant
In-Reply-To: <20170413133242.5068-6-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-6-andrew.smirnov@gmail.com>
Message-ID: <20170414155639.GC1792@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 06:32:39AM -0700, Andrey Smirnov wrote:
> List GPR block as compatible "fsl,imx6q-iomuxc-gpr" to support drivers
> requesting it that way (PCIe driver is one example).
> 
> Cc: yurovsky at gmail.com
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 1a7058f..cc23478 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -491,7 +491,8 @@
>  			};
>  
>  			gpr: iomuxc-gpr at 30340000 {
> -				compatible = "fsl,imx7d-iomuxc-gpr", "syscon";
> +				compatible = "fsl,imx7d-iomuxc-gpr",
> +					"fsl,imx6q-iomuxc-gpr", "syscon";

This looks wrong to me.
mx7d-iomux-gpr gets a big difference from mx6q-iomux-gpr and mostly
not compatible.

Regards
Dong Aisheng
