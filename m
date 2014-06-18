From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 16:16:21 +0100
Subject: [PATCH 7/7] pwm: st: Supply Device Tree binding documentation
 for ST's PWM IP
In-Reply-To: <CAG374jBJpmgv+X_ZT-Q6kj89p8BvVLb3sUsBHmD7GHF=jLQ=Ew@mail.gmail.com>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-7-git-send-email-lee.jones@linaro.org>
 <CAG374jBJpmgv+X_ZT-Q6kj89p8BvVLb3sUsBHmD7GHF=jLQ=Ew@mail.gmail.com>
Message-ID: <20140618151621.GB15956@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Gabriel Fernandez wrote:

> Hi Lee,
> minor remark below..
> 
> On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-st.txt | 41 ++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-st.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > new file mode 100644
> > index 0000000..ea88c5c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > @@ -0,0 +1,41 @@
> > +STMicroelectronics PWM driver bindings
> > +--------------------------------------
> 
> > +Example:
> > +
> > +pwm1: pwm at fe510000 {
> > +       compatible = "st,pwm";
> > +       reg = <0xfe510000 0x68>;
> > +       #pwm-cells = <2>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_pwm1_chan0_default
> > +                    &pinctrl_pwm1_chan1_default
> > +                    &pinctrl_pwm1_chan2_default
> > +                    &pinctrl_pwm1_chan3_default>;
> > +       clocks = <&CLK_SYSIN>;
> clock name in lower case

Good catch.  Will fix.

> > +       clock-names = "pwm";
> > +       st,pwm-num-chan = <4>;
> > +};
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
