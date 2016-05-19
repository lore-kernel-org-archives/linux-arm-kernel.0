From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 19 May 2016 13:04:02 +0300
Subject: [PATCH] ARM: lpc32xx: fix NR_IRQS confict
In-Reply-To: <1463646968-1047336-1-git-send-email-arnd@arndb.de>
References: <1463646968-1047336-1-git-send-email-arnd@arndb.de>
Message-ID: <573D8F92.3010902@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 19.05.2016 11:35, Arnd Bergmann wrote:
> With the change to sparse IRQs, the lpc32xx platform gets a warning about
> conflicting macros:
> 
> In file included from arch/arm/mach-lpc32xx/irq.c:31:0:
> arch/arm/mach-lpc32xx/include/mach/irqs.h:115:0: warning: "NR_IRQS" redefined
>  #define NR_IRQS    96
> arch/arm/include/asm/irq.h:9:0: note: this is the location of the previous definition
>  #define NR_IRQS NR_IRQS_LEGACY
> 
> In the irq controller driver, we surely need the local number instead of
> the generic NR_IRQS definition, so I'm renaming that one to LPC32XX_NR_IRQS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 8cb17b5ed017 ("irqchip: Add LPC32xx interrupt controller driver")

I think that the entire removal of arch/arm/mach-lpc32xx/irq.c is the proper fix,
since it is a dead code now - http://www.spinics.net/lists/arm-kernel/msg499976.html

I believe you can apply that change and add Fixes: tag.

--
With best wishes,
Vladimir
