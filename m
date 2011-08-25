From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 18:02:29 +0200
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <4E5000A1.8060609@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de> <4E5000A1.8060609@gmail.com>
Message-ID: <201108251802.29251.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 August 2011, Rob Herring wrote:
> >> +#ifndef _MACH_HIGHBANK__SYSREGS_H_
> >> +#define _MACH_HIGHBANK__SYSREGS_H_
> >> +
> >> +extern void __iomem *sregs_base;
> >> +
> >> +#define HB_SREG_A9_PWR_REQ          0xf00
> >> +#define HB_SREG_A9_BOOT_STAT                0xf04
> >> +#define HB_SREG_A9_BOOT_DATA                0xf08
> >> +
> >> +#define HB_PWR_SUSPEND                      0
> >> +#define HB_PWR_SOFT_RESET           1
> >> +#define HB_PWR_HARD_RESET           2
> >> +#define HB_PWR_SHUTDOWN                     3
> >> +
> >> +#endif
> > 
> > Do these really need to be global?
> > 
> > I think it's better to put the base address and register definitions into a
> > single file and export functions to be used from elsewhere.
> 
> Yes, sregs are a random collection of functions, so it's going to be a
> mixture of various users. Just HB_PWR_* alone are in 2 or 3 different
> places.

Sorry, I'm not following.

Do you mean 'yes, they need to be global' or 'yes, it's better to export
the functions'?

	Arnd
