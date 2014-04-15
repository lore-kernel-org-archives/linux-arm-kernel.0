From: chanho.min@lge.com (Chanho Min)
Date: Tue, 15 Apr 2014 09:07:00 +0900
Subject: [PATCH] arm64:kconfig: make default for CONFIG_COMPAT
In-Reply-To: <20140414164618.GC12916@arm.com>
References: <1397462883-12740-1-git-send-email-chanho.min@lge.com>
 <20140414164618.GC12916@arm.com>
Message-ID: <002201cf583e$9fb01f10$df105d30$@min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Tuesday, April 15, 2014 1:46 AM
> To: Chanho Min
> Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] arm64:kconfig: make default for CONFIG_COMPAT
> 
> On Mon, Apr 14, 2014 at 09:08:03AM +0100, Chanho Min wrote:
> > 'make savedefconfig' doesn't generate defconfig properly due to
> > missing COMPAT default. So Add default and set to yes.
> 
> I thought a missing `default' line in a Kconfig entry meant that the option
> ended up defaulting to 'n'. What exactly is the problem you are seeing?

Correct minimal config is not generated without default line.
If we want to set COMPAT to 'n', 'default n' should be added.

Chanho
> 
> Will
> 
> > Signed-off-by: Chanho Min <chanho.min@lge.com>
> > ---
> >  arch/arm64/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 4907b85..93b7531 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -294,6 +294,7 @@ source "fs/Kconfig.binfmt"
> >
> >  config COMPAT
> >  	bool "Kernel support for 32-bit EL0"
> > +	default y
> >  	depends on !ARM64_64K_PAGES
> >  	select COMPAT_BINFMT_ELF
> >  	select HAVE_UID16
> > --
> > 1.7.9.5
> >
> >
