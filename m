From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 20:29:05 +0000
Subject: [RFC PATCH] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <1349979450.16017.3.camel@gitbox>
References: <1349939831-12939-1-git-send-email-linux@prisktech.co.nz>
 <201210110747.46682.arnd@arndb.de> <1349979450.16017.3.camel@gitbox>
Message-ID: <201210112029.05572.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, Tony Prisk wrote:
> > config VT8500
> >       bool "Via/Wondermedia VT8500 / WM8505 / WM8650" if ARCH_MULTIPLATFORM
> >       default VT8500_SINGLE
> > 
> >       Arnd
> 
> Alexey (or anyone else),
> 
> Do you want it kept in the meantime?
> 
> I think the easiest way to add/keep it would be to create:
> 
> ARCH_VT8500_SINGLE (arm/Kconfig) and ARCH_VT8500_MULTI
> (arch-vt8500/Kconfig) and have them both select ARCH_VT8500 as an option
> to make drivers available.

You only need one new symbol, not too. Keeping CONFIG_VT8500 as the
user-selectable option as I outlined in the example means that
existing .config files keep working, which is sometimes useful.

	Arnd
