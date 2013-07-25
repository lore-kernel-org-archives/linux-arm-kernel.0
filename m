From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Jul 2013 13:00:34 +0200
Subject: [PATCH 1/2] ARM i.MX6Q: dts: Enable SPI NOR flash on Phytec
 phyFLEX-i.MX6 Ouad module
In-Reply-To: <20130725023605.GA7492@S2101-09.ap.freescale.net>
References: <1374683729-13438-1-git-send-email-p.zabel@pengutronix.de>
 <51F01DF0.3030207@cogentembedded.com>
 <20130725023605.GA7492@S2101-09.ap.freescale.net>
Message-ID: <1374750034.4297.29.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.07.2013, 10:36 +0800 schrieb Shawn Guo:
> On Wed, Jul 24, 2013 at 10:33:20PM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 07/24/2013 08:35 PM, Philipp Zabel wrote:
> > 
> > >Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > >---
> > >  arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > 
> > >diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> > >index f5e1981..5113d29 100644
> > >--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> > >+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> > >@@ -20,6 +20,20 @@
> > >  	};
> > >  };
> > >
> > >+&ecspi3 {
> > >+	pinctrl-names = "default";
> > >+	pinctrl-0 = <&pinctrl_ecspi3_1>;
> > >+	status = "okay";
> > >+	fsl,spi-num-chipselects = <1>;
> > >+	cs-gpios = <&gpio4 24 0>;
> > >+
> > >+	flash: m25p80 at 0 {
> > 
> >    Quoting the EPAPR spec [1]: "The name of a node should be
> > somewhat generic, reflecting the function of the device and not its
> > precise programming model. If appropriate, the name should be one of
> > the following choices:
> > [...]
> >    - flash
> 
> I fixed it up and applied the series.

thanks
Philipp
