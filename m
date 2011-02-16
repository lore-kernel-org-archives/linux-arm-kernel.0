From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Feb 2011 10:14:26 +0000
Subject: [PATCH V5 12/63] ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx
In-Reply-To: <20110216095615.GA6504@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<9a376f8d8a927e333a36a04e9e40e801dbfe398f.1295499394.git.viresh.kumar@st.com>
	<20110216095615.GA6504@n2100.arm.linux.org.uk>
Message-ID: <20110216101426.GC6504@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 09:56:15AM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 12:55:51PM +0530, Viresh Kumar wrote:
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index d916ac0..bf6632d 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -324,10 +324,22 @@ config FB_ARMCLCD
> >  
> >  choice
> >  
> > -	depends on FB_ARMCLCD && (ARCH_LH7A40X || ARCH_LH7952X)
> > +	depends on FB_ARMCLCD && (ARCH_LH7A40X || ARCH_LH7952X || ARCH_SPEAR6XX || MACH_SPEAR300 || MACH_SPEAR320)
> >  	prompt "LCD Panel"
> >  	default FB_ARMCLCD_SHARP_LQ035Q7DB02
> >  
> > +config FB_ARMCLCD_SHARP_LQ043T1DG01
> > +	bool "SHARP LQ043T1DG01 CLCD 4.2\" TFT(480x272)"
> > +	help
> > +	  This is an implementation of the Sharp LQ043T1DG01, a 4.2"
> > +	  color TFT panel. The native resolution is 480x272.
> > +
> > +config FB_ARMCLCD_SAMSUNG_LMS700
> > +	bool "SAMSUNG CLCD 7\" TFT(800x480)"
> > +	help
> > +	  This is an implementation of the Samsung LMS700, a 7"
> > +	  color TFT panel. The native resolution is 800x480.
> > +
> >  config FB_ARMCLCD_SHARP_LQ035Q7DB02_HRTFT
> >  	bool "LogicPD LCD 3.5\" QVGA w/HRTFT IC"
> >  	help
> 
> This choice stuff has gone with the removal of the lpd code from the
> kernel, and thus is unmergable.  This kind of platform specific
> configuration has no business being in this file anyway.

The other thing is that the handling of BGR/RGB has changed in the
'versatile' branch too, so you may want to delay this patch until
later.
