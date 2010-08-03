From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Aug 2010 11:08:13 +0200
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <201008021744.30560.arnd@arndb.de>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<20100802112403.GE30670@n2100.arm.linux.org.uk>
	<201008021744.30560.arnd@arndb.de>
Message-ID: <201008031108.13169.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 August 2010, Arnd Bergmann wrote:
> > Maybe the solution is to have a macro to initialize its entries, which
> > contain the cast to unsigned long for 'virtual' ?
> 
> Yes, that would work, though I would prefer to find a solution that works
> without new macros.

Well, scratch that. On second thought, the macro based solution seems to
have more advantages. arch/arm/mach-bcmring/mm.c already has a variant,
but I think I can come up with a more typesafe version that warns if
you pass in an integer for the virtual address of an MT_DEVICE mapping,
or a pointer for a RAM mapping.

	Arnd
