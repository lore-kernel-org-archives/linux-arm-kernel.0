From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 20:11:58 +0800
Subject: [PATCH 3/6] ARM: imx: add initial imx6dl support
In-Reply-To: <1365371979.4457.4.camel@smarty>
References: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
 <1364913079-26039-4-git-send-email-shawn.guo@linaro.org>
 <1365371979.4457.4.camel@smarty>
Message-ID: <20130408121155.GA5044@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 11:59:39PM +0200, Mathias Hasselmann wrote:
> Am Dienstag, den 02.04.2013, 22:31 +0800 schrieb Shawn Guo:
> > diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> > index 7dce17a..8629e5b 100644
> > --- a/arch/arm/mach-imx/mxc.h
> > +++ b/arch/arm/mach-imx/mxc.h
> > @@ -34,6 +34,8 @@
> >  #define MXC_CPU_MX35		35
> >  #define MXC_CPU_MX51		51
> >  #define MXC_CPU_MX53		53
> > +#define MXC_CPU_IMX6DL		0x61
> > +#define MXC_CPU_IMX6Q		0x63
> >  
> >  #define IMX_CHIP_REVISION_1_0		0x10
> >  #define IMX_CHIP_REVISION_1_1		0x11
> 
> Hi Shawn,
> 
> Are the hexadecimal values for MXC_CPU_IMX6DL and MXC_CPU_IMX6Q correct?

The hexadecimal values are correct.  They are defined so to match Chip
Silicon Version (ANALOG_DIGPROG) register.

> I ask because Freescale's imx_3.0.35_1.1.0 kernel defines MXC_CPU_MX6DL
> and MXC_CPU_MX6Q with the decimal numbers 61 and 63.

In Freescale kernel, the value does not really matter, since the kernel
will use the macros in mxc_set_cpu_type() call.

Shawn
