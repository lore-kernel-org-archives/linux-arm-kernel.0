From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 2 Feb 2012 16:22:29 +0800
Subject: [PATCH v2 9/9] ARM: imx6q-sabrelite: add audmux support
In-Reply-To: <20120202082807.GA3653@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-10-git-send-email-richard.zhao@linaro.org>
 <20120202082807.GA3653@S2101-09.ap.freescale.net>
Message-ID: <20120202082228.GA32403@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 04:30:24PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 10:12:08AM +0800, Richard Zhao wrote:
> > - enable audmux in dts
> > - enable audmux in Kconfig
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
> >  arch/arm/boot/dts/imx6q.dtsi          |    2 ++
> >  arch/arm/mach-imx/Kconfig             |    1 +
> >  3 files changed, 7 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > index 3a9d32c..5cd6698 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -41,6 +41,10 @@
> >  				status = "okay";
> >  			};
> >  
> > +			audmux at 021d8000 {
> > +				status = "okay";
> > +			};
> > +
> >  			uart2: uart at 021e8000 {
> >  				status = "okay";
> >  			};
> > diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> > index 263e8f3..b0ae495 100644
> > --- a/arch/arm/boot/dts/imx6q.dtsi
> > +++ b/arch/arm/boot/dts/imx6q.dtsi
> > @@ -527,7 +527,9 @@
> >  			};
> >  
> >  			audmux at 021d8000 {
> > +				compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
> >  				reg = <0x021d8000 0x4000>;
> > +				status = "disabled";
> >  			};
> >  
> >  			mipi at 021dc000 { /* MIPI-CSI */
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 4defb97..1aec9c1 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -835,6 +835,7 @@ comment "i.MX6 family:"
> >  config SOC_IMX6Q
> >  	bool "i.MX6 Quad support"
> >  	select ARM_CPU_SUSPEND if PM
> > +	select ARCH_MXC_AUDMUX_V2
> 
> The ARCH_MXC_AUDMUX_V2 has been removed by patch #7.  Why do you select
> it here?
I forgot to remove it when rebase. I can be removed.

Thanks
Richard
> 
> Regards,
> Shawn
> 
> >  	select ARM_GIC
> >  	select CPU_V7
> >  	select HAVE_ARM_SCU
> > -- 
> > 1.7.5.4
> > 
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
