From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jan 2016 11:42:05 +0100
Subject: [PATCH] ARM: debug-ll: fix BCM63xx entry for multiplatform
In-Reply-To: <20160118095919.GE19062@n2100.arm.linux.org.uk>
References: <5641204.G6RtGs3Kji@wuerfel>
 <20160118095919.GE19062@n2100.arm.linux.org.uk>
Message-ID: <7401195.yJZcvlhzfd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 January 2016 09:59:19 Russell King - ARM Linux wrote:
> On Mon, Jan 18, 2016 at 10:51:00AM +0100, Arnd Bergmann wrote:
> > During my randconfig build testing, I found that a kernel with
> > DEBUG_AT91_UART and ARCH_BCM_63XX fails to build:
> > 
> > arch/arm/include/debug/at91.S:18:0: error: "CONFIG_DEBUG_UART_VIRT" redefined [-Werror]
> 
> Why do we have files defining CONFIG_* symbols?  This is the real error
> here - no source file should be defining this.

I agree that we should change that too, I'll send a patch for it as well.

However, this just let me stumble on the problem, without AT91 getting this
wrong, I would not have noticed that bcm63xx breaks other platforms.
The AT91 thing is just confusing but otherwise harmless, and I wouldn't
mark that fix for stable.

	Arnd
