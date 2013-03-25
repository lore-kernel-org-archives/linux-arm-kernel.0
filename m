From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 15:13:21 +0000
Subject: [PATCH 5/6] ARM: ux500: move PRCMU functions into the CPUidle
 driver
In-Reply-To: <CACRpkda=FT1cHA=2oZkNcxxB=NvGLbuKia=hHkxSzEBu07CL8g@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <201303251411.43356.arnd@arndb.de>
 <CACRpkda=FT1cHA=2oZkNcxxB=NvGLbuKia=hHkxSzEBu07CL8g@mail.gmail.com>
Message-ID: <201303251513.21361.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Linus Walleij wrote:
> This set of functions are called both for idling and suspend, i.e.
> both by the machine-specific cpuidle driver and the machine-specific
> suspend code.
> 
> They are conceptually coherent functions but messing with both PRCMU
> and GIC registers, moving the responsibility of keeping track of the
> IRQs back and forth between the GIC and the PRCMU.
> 
> Being able to freeze and decouple the GIC and check if a CPU is
> in WFI is a ux500-PRCMU-specific pecularity but saves us a lot of
> criss-cross IPIs when going to idle or sleep.

I still don't understand. From what I can tell, all those functions are
now statically declared in the cpuidle driver after your patch, so it
sounds like you do not need a header file for them any more, where
you needed one before. Which of those would you declare in a hypothetical
linux/pm/ux500.h header file?

	Arnd
