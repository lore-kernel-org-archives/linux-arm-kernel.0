From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Mar 2012 18:33:26 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <201203170905.33191.arnd@arndb.de>
 <CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
Message-ID: <201203171833.27068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 March 2012, Turquette, Mike wrote:
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 2eaf17e..a0a83de 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -12,7 +12,7 @@ config HAVE_MACH_CLKDEV
> >
> >  menuconfig COMMON_CLK
> > -       bool "Common Clock Framework"
> > +       bool
> >        select HAVE_CLK_PREPARE
> >        ---help---
> >          The common clock framework is a single definition of struct
> >          clk, useful across many platforms, as well as an
> 
> Much like experimental I'm not sure how needed this change is.  The
> help section does say to leave it disabled by default, if unsure.  If
> you merge it I won't object but this might be fixing an imaginary
> problem.

Well, it doesn't have any consequences for real users, but it I think it
does for randconfig builds, which we are trying to repair currently.

	Arnd
