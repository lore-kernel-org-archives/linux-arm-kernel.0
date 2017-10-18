From: rui.zhang@intel.com (Zhang Rui)
Date: Wed, 18 Oct 2017 09:47:26 +0800
Subject: linux-next: manual merge of the thermal tree with the imx-mxs tree
In-Reply-To: <20171016091728.gbtoakghi4ndyyt2@sirena.co.uk>
References: <20171016091728.gbtoakghi4ndyyt2@sirena.co.uk>
Message-ID: <1508291246.2746.41.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

thanks for the fix.

On Mon, 2017-10-16 at 10:17 +0100, Mark Brown wrote:
> Hi Zhang,
> 
> Today's linux-next merge of the thermal tree got a conflict in:
> 
> ? arch/arm/boot/dts/imx6ul.dtsi
> 
> between commit:
> 
> ???efb9adb274754 ("ARM: dts: imx6ul: Remove leading zeroes from unit
> addresses")
> 
> from the imx-mxs tree and commit:
> 
> ???1dc31d4981dd9 ("ARM: dts: imx6ul: Add imx6ul-tempmon")
> 
> from the thermal tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your
> tree
> is submitted for merging.??You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any
> particularly
> complex conflicts.??Usually DTS changes go through arm-soc to avoid
> issues like this.

Shawn,

https://patchwork.kernel.org/patch/9841191/
https://patchwork.kernel.org/patch/9841193/
Should I drop these two dts patches and leave them to you?

thanks,
rui

> 
> diff --cc arch/arm/boot/dts/imx6ul.dtsi
> index 2057ee695a66,51717d54f285..000000000000
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@@ -860,13 -869,23 +869,23 @@@
> ??				reg = <0x021b0000 0x4000>;
> ??			};
> ??
> ?-			ocotp: ocotp-ctrl at 021bc000 {
> ?+			ocotp: ocotp-ctrl at 21bc000 {
> +?				#address-cells = <1>;
> +?				#size-cells = <1>;
> ??				compatible = "fsl,imx6ul-ocotp",
> "syscon";
> ??				reg = <0x021bc000 0x4000>;
> ??				clocks = <&clks IMX6UL_CLK_OCOTP>;
> +?
> +?				tempmon_calib: calib at 38 {
> +?					reg = <0x38 4>;
> +?				};
> +?
> +?				tempmon_temp_grade: temp-grade at 20 {
> +?					reg = <0x20 4>;
> +?				};
> ??			};
> ??
> ?-			lcdif: lcdif at 021c8000 {
> ?+			lcdif: lcdif at 21c8000 {
> ??				compatible = "fsl,imx6ul-lcdif",
> "fsl,imx28-lcdif";
> ??				reg = <0x021c8000 0x4000>;
> ??				interrupts = <GIC_SPI 5
> IRQ_TYPE_LEVEL_HIGH>;
