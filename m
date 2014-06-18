From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 16:16:52 +0100
Subject: [PATCH 1/7] ARM: stih407: Add DT nodes for for PWM
In-Reply-To: <CAG374jCGhjACBr1a86_W6wQYWq8_CofwSFxZO+4j=3aHQC2nmg@mail.gmail.com>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <CAG374jCGhjACBr1a86_W6wQYWq8_CofwSFxZO+4j=3aHQC2nmg@mail.gmail.com>
Message-ID: <20140618151652.GC15956@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Gabriel Fernandez wrote:

> Hi Lee,
> minor remark below..
> 
> On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> > Supply top level nodes for the STiH407 based development boards.
> > The Pinctrl configuration has already been applied, so the only
> > missing piece of the DT puzzle is for a board's DTB to enable
> > the nodes.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407.dtsi | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
> > index 4f9024f..6b43ba2 100644
> > --- a/arch/arm/boot/dts/stih407.dtsi
> > +++ b/arch/arm/boot/dts/stih407.dtsi
> > @@ -259,5 +259,32 @@
> >
> >                         status = "disabled";
> >                 };
> > +
> > +               /* COMMS PWM Module */
> > +               pwm0: pwm at 9810000 {
> > +                       compatible      = "st,sti-pwm";
> > +                       status          = "disabled";
> > +                       #pwm-cells      = <2>;
> > +                       reg             = <0x9810000 0x68>;
> > +                       pinctrl-names   = "default";
> > +                        pinctrl-0      = <&pinctrl_pwm0_chan0_default>;
> del space

Fixing, thanks.

> > +                       clock-names     = "pwm";
> > +                       clocks          = <&clk_sysin>;
> > +               };
> > +
> > +               /* SBC PWM Module */
> > +               pwm1: pwm at 9510000 {
> > +                       compatible      = "st,sti-pwm";
> > +                       status          = "disabled";
> > +                       #pwm-cells      = <2>;
> > +                       reg             = <0x9510000 0x68>;
> > +                       pinctrl-names   = "default";
> > +                       pinctrl-0       = <&pinctrl_pwm1_chan0_default
> > +                                       &pinctrl_pwm1_chan1_default
> > +                                       &pinctrl_pwm1_chan2_default
> > +                                       &pinctrl_pwm1_chan3_default>;
> > +                       clock-names     = "pwm";
> > +                       clocks          = <&clk_sysin>;
> > +               };
> >         };
> >  };
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
