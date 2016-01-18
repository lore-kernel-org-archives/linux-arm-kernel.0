From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Jan 2016 11:07:06 -0800
Subject: [PATCH] ARM: debug-ll: fix BCM63xx entry for multiplatform
In-Reply-To: <5641204.G6RtGs3Kji@wuerfel>
References: <5641204.G6RtGs3Kji@wuerfel>
Message-ID: <569D37DA.7090309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/01/2016 01:51, Arnd Bergmann a ?crit :
> During my randconfig build testing, I found that a kernel with
> DEBUG_AT91_UART and ARCH_BCM_63XX fails to build:
> 
> arch/arm/include/debug/at91.S:18:0: error: "CONFIG_DEBUG_UART_VIRT" redefined [-Werror]
> 
> It turns out that the DEBUG_UART_BCM63XX option is enabled whenever
> the ARCH_BCM_63XX is, and that breaks multiplatform kernels because
> we then end up using the UART address from BCM63XX rather than the
> one we actually configured (if any).
> 
> This changes the BCM63XX options to only have one Kconfig option,
> and only enable that if the user explicitly turns it on.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b51312bebfa4 ("ARM: BCM63XX: add low-level UART debug support")
> Cc: stable at vger.kernel.org

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for spotting this.
-- 
Florian
