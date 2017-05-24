From: aisheng.dong@nxp.com (A.S. Dong)
Date: Wed, 24 May 2017 03:10:12 +0000
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <20170523182321.GA13664@w540>
References: <1495539829-23345-1-git-send-email-aisheng.dong@nxp.com>
 <20170523182321.GA13664@w540>
Message-ID: <AM3PR04MB3065626F1B45C8459E5765580FE0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J

> -----Original Message-----
> From: jmondi [mailto:jacopo at jmondi.org]
> Sent: Wednesday, May 24, 2017 2:24 AM
> To: A.S. Dong
> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at linaro.org; shawnguo at kernel.org; stefan at agner.ch; Jacky Bai;
> Andy Duan; kernel at pengutronix.de; Rob Herring; Mark Rutland;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH V3 1/2] dt-bindings: pinctrl: add imx7ulp pinctrl
> binding doc
> 
> Hi Dong,
> 
> On Tue, May 23, 2017 at 07:43:48PM +0800, Dong Aisheng wrote:
> > i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
> > IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.
> >
> > This patch adds the IOMUXC1 support for A7.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > ChangeLog:
> > v2->v3:
> >  * switch to generic input/output-enable property
> > v1->v2:
> >  * add more descriptions in binding doc
> >  * add missed prefix for private properties.
> >  * move dt-bindings/pinctrl/imx7ulp-pinfunc.h to arch/arm/boot/dts
> > ---
> >  .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |  63 +++
> >  arch/arm/boot/dts/imx7ulp-pinfunc.h                | 468
> +++++++++++++++++++++
> >  2 files changed, 531 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> >  create mode 100644 arch/arm/boot/dts/imx7ulp-pinfunc.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> > b/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> > new file mode 100644
> > index 0000000..67e4d1e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.tx
> > +++ t
> > @@ -0,0 +1,63 @@
> > +* Freescale i.MX7ULP IOMUX Controller
> > +
> > +i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports, IOMUXC1
> > +for A7 ports and IOMUXC DDR for DDR interface.
> > +
> > +Note:
> > +This binding doc is only for the IOMUXC1 support in A7 Domain and it
> > +only supports generic pin config.
> > +
> > +Please also refer to fsl,imx-pinctrl.txt in this directory for IMX
> > +common binding part and pinctrl-bindings.txt for the generic config
> binding.
> > +
> > +=== Pin Controller Node ===
> > +
> > +Required properties:
> > +- compatible:	"fsl,imx7ulp-iomuxc1"
> > +- reg:		Should contain the base physical address and size of the
> iomuxc
> > +		registers.
> > +
> > +=== Pin Configuration Node ===
> > +- pins: One integers array, represents a group of pins mux setting.
> > +	The format is fsl,pins = <PIN_FUNC_ID>, PIN_FUNC_ID is a pin working
> on
> > +	a specific function.
> > +
> > +	NOTE: i.MX7ULP PIN_FUNC_ID consists of 4 integers as it shares one
> mux
> > +	and config register as follows:
> > +	<mux_conf_reg input_reg mux_mode input_val>
> 
> As your PIN_FUNC_ID specifies both the pin ids and their mux settings,
> shouldn't you use the newly documented 'pinmux' property in place of
> 'pins'?
> 
> Please see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> ?id=8d5e7c5df0a6c442373628be5221321172b1badf
> 
> The current documentation specifies pin ids and mux settings have to be
> assembled in one single integer, which is not your case, but that can be
> changed to make it accept an array of integers values if needed.
> 

Thanks for the info.
Looks good to me.

Shawn & Linus,
Are you okay with this?

If yes, I can extend the standard 'pinmux' property to support integer array
and renew the patch series to use it.

Regards
Dong Aisheng
