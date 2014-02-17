From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 17 Feb 2014 08:35:43 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDI3LXBoeXRlYy1waHljb3JlLSo6?=
 =?UTF-8?B?IEFkZCBkaWFnbm9zdGljIFBNSUMgTEVEcw==?=
In-Reply-To: <20140217025527.GG9879@S2101-09.ap.freescale.net>
References: <1392464118-3353-1-git-send-email-shc_work@mail.ru>
 <20140217025527.GG9879@S2101-09.ap.freescale.net>
Message-ID: <1392611743.839161955@f87.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 17 ??????? 2014, 10:55 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
> On Sat, Feb 15, 2014 at 03:35:18PM +0400, Alexander Shiyan wrote:
> > PCM-038 module have three triple LEDs connected to PMIC which
> > can be used for diagnostic purposes. This patch adds support
> > for these LEDs for PCM-038 SOM and adds basic LED-triggers for
> > these LEDs for PCM-970 RDK, the remaining LEDs are available
> > for use from userspace.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  | 50
> +++++++++++++++++++++++++
> >  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi |  6 +++
> >  2 files changed, 56 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > index 9f8ad51..9a07543 100644
> > --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
...
> > +	ledr3: led at 9 {
> > +		reg = <9>;
> > +		label = "system:red3:nand";
> > +		linux,default-trigger = "nand-disk";
> > +	};
> > +
> > +	ledg3: led at 10 {
> > +		reg = <10>;
> > +		label = "system:green3:live";
> > +		linux,default-trigger = "heartbeat";
> > +	};
> > +
> > +	ledb3: led at 11 {
> > +		reg = <11>;
> > +		label = "system:blue3:cpu";
> > +		linux,default-trigger = "cpu0";
> 
> 
> I do not see this trigger and above "nand-disk" in
> Documentation/devicetree/bindings/leds/common.txt.
> So they're just missing from bindings doc and kernel actually supports
> them?

Yes, seems this is undocumented yet.
Defined in drivers/mtd/nand/nand_base.c: nand_base_init().
Present in the mainline kernel.

...
> > +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> > @@ -69,6 +69,12 @@
> >  		fsl,mc13xxx-uses-adc;
> >  		fsl,mc13xxx-uses-rtc;
> >  
> > +		pmicleds: leds {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			led-control = <0x001 0x000 0x000 0x000 0x000 0x000>;
> 
> I can only see led-control mentioned in
> Documentation/devicetree/bindings/mfd/mc13xxx.txt as below.
> 
> - leds : Contain the led nodes and initial register values in property
> "led-control".
> 
> But I failed to see where this property is actually defined.

Not quite understand the question. Please rephrase.

---
