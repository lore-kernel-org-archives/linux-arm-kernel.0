From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 May 2013 15:35:03 +0200
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
In-Reply-To: <20130516085711.GP18614@n2100.arm.linux.org.uk>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
 <201305160054.21064.arnd@arndb.de>
 <20130516085711.GP18614@n2100.arm.linux.org.uk>
Message-ID: <201305161535.03742.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 May 2013, Russell King - ARM Linux wrote:
> Well, if its a CPU core thing, then it's even easier - the proc-*.S
> file can handle it just fine (because that's where the WFI code is.)
> Just delete the contents of the processor specific idle function, IOW:
> 
> /*
>  * cpu_fa526_do_idle()
>  */
>         .align  4
> ENTRY(cpu_fa526_do_idle)
>         mcr     p15, 0, r0, c7, c0, 4           @ Wait for interrupt
>         mov     pc, lr
> 
> remove the WFI from there.

Yes, that was what I meant.

	Arnd
