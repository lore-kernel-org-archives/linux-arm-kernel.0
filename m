From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 May 2015 10:33:05 +0200
Subject: [PATCH v2] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <55657A35.2090402@gmail.com>
References: <1432713573-32147-1-git-send-email-antoine.tenart@free-electrons.com>
 <55657A35.2090402@gmail.com>
Message-ID: <20150527083305.GD27202@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, May 27, 2015 at 10:03:01AM +0200, Sebastian Hesselbarth wrote:
> On 27.05.2015 09:59, Antoine Tenart wrote:
> >The BG2Q SoC has two SPI controllers. Add the corresponding nodes.
> >
> >Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> >---
> >
> >Changes since v1:
> >	- reworked the pinmux
> >	- removed useless interrupt-parent properties
> >	- typo
> >
> >  arch/arm/boot/dts/berlin2q.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> >index 187d056f7ad2..9f42ebfa50f2 100644
> >--- a/arch/arm/boot/dts/berlin2q.dtsi
> >+++ b/arch/arm/boot/dts/berlin2q.dtsi
> >@@ -286,6 +286,19 @@
> >  				status = "disabled";
> >  			};
> >
> >+			spi0: spi at 1c00 {
> >+				compatible = "snps,dw-apb-ssi";
> >+				reg = <0x1c00 0x100>;
> >+				interrupts = <7>;
> >+				clocks = <&chip_clk CLKID_CFG>;
> >+				pinctrl-0 = <&spi1_pmux>;
> 
> Antoine,
> 
> you missed s/spi0/spi1/ and the same for the node below?

I think we had a misunderstanding then :) You would like to have spi1
and spi2 nodes, without having an spi0 one?

> BTW, you have any SPI device to test this? If you are brave
> enough you could read the flash from the Berlin secure boot
> SPI key ;)

Until now, I tested it using spidev and connecting SDI to SDO.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
