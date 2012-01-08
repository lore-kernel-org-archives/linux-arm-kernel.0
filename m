From: richard.zhao@freescale.com (Richard Zhao)
Date: Sun, 8 Jan 2012 22:58:14 +0800
Subject: [PATCH 6/6] ARM: imx6q-sabrelite: add audmux support
In-Reply-To: <20120108150234.GF20216@S2101-09.ap.freescale.net>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-7-git-send-email-richard.zhao@linaro.org>
 <20120108150234.GF20216@S2101-09.ap.freescale.net>
Message-ID: <20120108145813.GA23822@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 11:02:36PM +0800, Shawn Guo wrote:
> On Fri, Jan 06, 2012 at 11:25:43AM +0800, Richard Zhao wrote:
> > --- a/arch/arm/boot/dts/imx6q.dtsi
> > +++ b/arch/arm/boot/dts/imx6q.dtsi
> > @@ -527,7 +527,9 @@
> >  			};
> >  
> >  			audmux at 021d8000 {
> > +				compatible = "fsl,audmux-v2";
> 
> This is not a good compatible string, because the version number is
> not defined by hardware.  Even it is defined by hardware, the version
> number is not as stable as soc to identify specific hardware block.
> You can look at uart, cspi, sdma etc. for examples.
compatible = "fsl,imx6q-audmux", "fsl,imx25-audmux";
I forgot imx25 or imx31 is oldest. Is it ok for you?

Thanks
Richard
> 
> >  				reg = <0x021d8000 0x4000>;
> > +				status = "disabled";
> >  			};
> 
> -- 
> Regards,
> Shawn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
