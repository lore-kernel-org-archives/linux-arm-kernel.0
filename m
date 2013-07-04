From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Jul 2013 10:16:24 +0530
Subject: [PATCH v3 2/8] wlcore: set irq_flags in the board files instead
 of hiding behind a quirk
In-Reply-To: <1372860209-3504-3-git-send-email-coelho@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-3-git-send-email-coelho@ti.com>
Message-ID: <51D4FE20.6000805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/3/2013 7:33 PM, Luciano Coelho wrote:
> The platform_quirk element in the platform data was used to change the
> way the IRQ is triggered.  When set, the EDGE_IRQ quirk would change
> the irqflags used and treat edge trigger differently from the rest.
> 
> Instead of hiding this irq flag setting behind the quirk, have the
> board files set the flags during initialization.  This will be more
> meaningful than driver-specific quirks when we switch to DT.
> 
> Additionally, fix missing gpio_request() calls in the boarding files
> (so that setting the flags actually works).
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c      |    8 +++++-

For the board-da850-evm.c change,

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
