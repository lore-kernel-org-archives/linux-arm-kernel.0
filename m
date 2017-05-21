From: aisheng.dong@nxp.com (A.S. Dong)
Date: Sun, 21 May 2017 09:40:25 +0000
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <20170521093049.GM26102@dragon>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
 <20170521093049.GM26102@dragon>
Message-ID: <AM3PR04MB306654DEA7C2B7676D5C0EC80FB0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Sunday, May 21, 2017 5:31 PM
> To: A.S. Dong
> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at linaro.org; stefan at agner.ch; Jacky Bai; Andy Duan;
> kernel at pengutronix.de; Rob Herring; Mark Rutland;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl
> binding doc
> 
> On Fri, May 19, 2017 at 03:05:44PM +0800, Dong Aisheng wrote:
> > i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
> > IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.
> >
> > This patch adds the IOMUXC1 support for A7.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > ChangeLog:
> > v1->v2:
> >  * add more descriptions in binding doc
> >  * add missed prefix for private properties.
> >  * move dt-bindings/pinctrl/imx7ulp-pinfunc.h to arch/arm/boot/dts
> > ---
> >  .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |  63 +++
> >  arch/arm/boot/dts/imx7ulp-pinfunc.h                | 468
> +++++++++++++++++++++
> 
> Rather than being part of bindings doc patch, this pinfunc header should
> be included in dts patches that add imx7ulp SoC support.
> 

Okay.
One question is that imx7ulp-pinfunc.h is mentioned in this binding doc, 
that means after this patch applied, users still can't see it if separate,
Should we worry about this issue or not?
 
+       Refer to imx7ulp-pinfunc.h in in device tree source folder for all
+       available imx7ulp PIN_FUNC_ID.

Last, thx for other ACKs.

Regards
Dong Aisheng

> Shawn
> 
> >  2 files changed, 531 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
> >  create mode 100644 arch/arm/boot/dts/imx7ulp-pinfunc.h
