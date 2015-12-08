From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Dec 2015 15:37:09 +0000
Subject: [PATCH v5 04/11] ARM: STi: STiH407: Provide generic (safe) DVFS
 configuration
In-Reply-To: <20151208150340.GI3692@ubuntu>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-5-git-send-email-lee.jones@linaro.org>
 <20151208150340.GI3692@ubuntu>
Message-ID: <20151208153709.GA14604@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Dec 2015, Viresh Kumar wrote:

> On 08-12-15, 14:31, Lee Jones wrote:
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index 81f8121..9fa1e58 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -22,15 +22,29 @@
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a9";
> >  			reg = <0>;
> > +
> >  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> >  			cpu-release-addr = <0x94100A4>;
> > +
> > +					 /* kHz     uV   */
> > +			operating-points = <1500000 0
> > +					    1200000 0
> > +					    800000  0
> > +					    500000  0>;
> >  		};
> >  		cpu at 1 {
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a9";
> >  			reg = <1>;
> > +
> >  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> >  			cpu-release-addr = <0x94100A4>;
> > +
> > +					 /* kHz     uV   */
> > +			operating-points = <1500000 0
> > +					    1200000 0
> > +					    800000  0
> > +					    500000  0>;
> 
> Why didn't you move to opp-v2 ?
 
Because we can't guarantee that the system was booted with a
bootloader which supports opp-v2.  This is the fall-back
configuration.  Please continue through the set.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
