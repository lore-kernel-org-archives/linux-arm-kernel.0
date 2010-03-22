From: hjk@linutronix.de (Hans J. Koch)
Date: Mon, 22 Mar 2010 23:24:58 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <63386a3d1003221413p29784233rc0952fba5d921e18@mail.gmail.com>
References: <20100322191900.GF2040@bluebox.local>
	<20100322192748.GK2040@bluebox.local>
	<63386a3d1003221413p29784233rc0952fba5d921e18@mail.gmail.com>
Message-ID: <20100322222458.GA2547@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 10:13:53PM +0100, Linus Walleij wrote:
> 2010/3/22 Hans J. Koch <hjk@linutronix.de>:
> 
> > Map the IO ranges of TCC8xxx peripherals.
> > (...)
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .virtual ? ? ? ?= DATA_TCM_BASE_VIRT, ? /* Data TCM */
> > + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(DATA_TCM_BASE),
> > + ? ? ? ? ? ? ? .length ? ? ? ? = DATA_TCM_SIZE,
> > + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> > + ? ? ? },
> 
> Hey, that no peripheral, that's onchip TCM memory, MT_DEVICE is
> very inappropriate since it will cause readthrough/writethrough.
> 
> Please use the generic TCM memory support as described in
> Documentation/arm/tcm.txt for your TCM memory, example of
> a platform using this can be found in arch/arm/mach-u300,
> just grep -r for TCM. Note the flag in arch/arm/Kconfig as well.

Thanks for that hint. Will fix.

Hans

> 
> Any problems, ask.
> 
> Yours,
> Linus Walleij
