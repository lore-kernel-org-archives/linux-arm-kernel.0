From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 21 Apr 2014 03:08:34 +0000
Subject: [PATCH v5 3/3] ARM: dts: sama5d3xcm: add the regulator device node
In-Reply-To: <5351985C.4090308@atmel.com>
References: <1387852421-18033-1-git-send-email-wenyou.yang@atmel.com>
 <1387852570-18159-1-git-send-email-wenyou.yang@atmel.com>
 <5351985C.4090308@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364180A855DE@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> -----Original Message-----
> From: Ferre, Nicolas
> Sent: Saturday, April 19, 2014 5:26 AM
> To: Yang, Wenyou
> Cc: broonie at kernel.org; lgirdwood at gmail.com; grant.likely at linaro.org;
> rob.herring at calxeda.com; plagnioj at jcrosoft.com; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-
> doc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v5 3/3] ARM: dts: sama5d3xcm: add the regulator
> device node
> 
> On 24/12/2013 03:36, Wenyou Yang :
> > Reviwed-by: Mark Brown <broonie@linaro.org>
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Wenyou,
> 
> While collecting patches for our next at91-3.16-dt branch I noticed
> this patch that should go on top of the SAMA5D3 CMP board.
> 
> I would prefer to create another .dtsi file for CMP board and not mix
> with the current cpu module usual board that does not contain this
> regulator. But well we can do something even more simpler and move this
> PMIC example to the newer SAMA5D3 Xplained board.
> 
> So, will it be possible for you to re-send a new patch targeted to
> SAMA5D3 Xplained?
OK, I will re-send a new patch.

> 
> Thanks, bye.
> 
> 
> > ---
> >  arch/arm/boot/dts/sama5d3xcm.dtsi |   46
> +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi
> > b/arch/arm/boot/dts/sama5d3xcm.dtsi
> > index 726a0f3..3d4e5c2 100644
> > --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
> > +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
> > @@ -38,6 +38,52 @@
> >  			macb0: ethernet at f0028000 {
> >  				phy-mode = "rgmii";
> >  			};
> > +
> > +			i2c1: i2c at f0018000 {
> > +				pmic: act8865 at 5b {
> > +					compatible = "active-semi,act8865";
> > +					reg = <0x5b>;
> > +					status = "disabled";
> > +
> > +					regulators {
> > +						vcc_1v8_reg: DCDC_REG1 {
> > +							regulator-name = "VCC_1V8";
> > +							regulator-min-microvolt =
> <1800000>;
> > +							regulator-max-microvolt =
> <1800000>;
> > +							regulator-always-on;
> > +						};
> > +
> > +						vcc_1v2_reg: DCDC_REG2 {
> > +							regulator-name = "VCC_1V2";
> > +							regulator-min-microvolt =
> <1100000>;
> > +							regulator-max-microvolt =
> <1300000>;
> > +							regulator-suspend-mem-
> microvolt = <1150000>;
> > +							regulator-suspend-standby-
> microvolt = <1150000>;
> > +							regulator-always-on;
> > +						};
> > +
> > +						vcc_3v3_reg: DCDC_REG3 {
> > +							regulator-name = "VCC_3V3";
> > +							regulator-min-microvolt =
> <3300000>;
> > +							regulator-max-microvolt =
> <3300000>;
> > +							regulator-always-on;
> > +						};
> > +
> > +						vddana_reg: LDO_REG1 {
> > +							regulator-name = "VDDANA";
> > +							regulator-min-microvolt =
> <3300000>;
> > +							regulator-max-microvolt =
> <3300000>;
> > +							regulator-always-on;
> > +						};
> > +
> > +						vddfuse_reg: LDO_REG2 {
> > +							regulator-name = "FUSE_2V5";
> > +							regulator-min-microvolt =
> <2500000>;
> > +							regulator-max-microvolt =
> <2500000>;
> > +						};
> > +					};
> > +				};
> > +			};
> >  		};
> >
> >  		nand0: nand at 60000000 {
> >
> 
> 
> --
> Nicolas Ferre

Best Regards,
Wenyou Yang
