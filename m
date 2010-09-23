From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Sep 2010 13:22:41 +0200
Subject: [PATCH] at91: drop at91x40 support
In-Reply-To: <4C9702E9.8020500@snapgear.com>
References: <1284790974-11143-1-git-send-email-plagnioj@jcrosoft.com>
	<4C94875B.3060200@snapgear.com>
	<20100918142857.GA12003@game.jcrosoft.org>
	<4C96F63A.2090704@snapgear.com>
	<20100920063243.GA32018@game.jcrosoft.org>
	<4C9702E9.8020500@snapgear.com>
Message-ID: <20100923112241.GB32018@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>no debug-macro.S for years
> >>>since what 4 or 5 years we just have the timer and irq
> >>
> >>I don't follow. What is wrong with
> >>arch/arm/mach-at91/include/mach/debug-macro.S?
> >the at91x40 can not use it as it's not have DBGU support
> 
> Yes, thats right. But it causes no problems.
just very hard to debug
> 
> 
> >>The AT91x40 parts are pretty simple, what else do you expect?
> >>
> >>>do you have plan to update it?
> >>
> >>I don't see anything to update. It does exactly what I want it to do.
> >>The board support code you point at causes me no troubles, and not
> >>very often do I need to fix/change/update it.
> >you have no flash,
> 
> Uh?  That doesn't need to go into the board support file.
> (And my use case doesn't use flash anyway).
> 
> 
> >no uart, no pio support, no watchdog supportm so tc support,
> 
> I don't need or want most of those. If someone else needs them
> they can add them.
> 
> 
> >the CPU type is no even selected in the Kconfig
> 
> What, you can't select "AT91x40" in menuconfig?
cpu type ARM7TDMI

> 
> 
> >so yes the current implementation is not really usefull for anything
> 
> I use it. I do my main work on non-MMU code on ARM using this base.
> It is very useful to me.
as you use an emulator but for a real hardware it's not

have the uart debug-macro.S for the kernel is a minimal requirement in my mind

and could u send a defconfig please

Best Regards,
J.
