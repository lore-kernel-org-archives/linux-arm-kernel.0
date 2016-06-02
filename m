From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Jun 2016 18:30:56 +0100
Subject: [PATCH 01/32] arm64: Add platform selection for BCM2835.
In-Reply-To: <1464849936.24775.33.camel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-2-git-send-email-kraxel@redhat.com>
 <574F5881.4060008@gmail.com> <1464849936.24775.33.camel@redhat.com>
Message-ID: <20160602173055.GG24938@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 08:45:36AM +0200, Gerd Hoffmann wrote:
> > > +config ARCH_BCM2835
> > > +	bool "Broadcom BCM2835 family"
> > > +	depends on ARCH_BCM
> > > +	select ARCH_REQUIRE_GPIOLIB
> > > +	select CLKSRC_OF
> > > +	select PINCTRL
> > > +	select PINCTRL_BCM2835
> > > +	select ARM_AMBA
> > > +	select ARM_TIMER_SP804
> > > +	select HAVE_ARM_ARCH_TIMER
> > > +	help
> > > +	  This enables support for the Broadcom BCM2837 SoC.
> > > +	  This SoC is used in the Raspberry Pi 3 device.
> > > +
> > >  config ARCH_BCM_IPROC
> > >  	bool "Broadcom iProc SoC Family"
> > > +	depends on ARCH_BCM
> > 
> > Does not seem necessary nor adding anything here.
> 
> Added for consistency.  When we add ARCH_BCM all ARCH_BCM_* should
> depend on it ...

For arm64, I prefer to keep Kconfig.platforms to SoC families only. I
don't think we have any single-SoC Kconfig entry left now.

-- 
Catalin
