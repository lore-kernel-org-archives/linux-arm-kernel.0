From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Feb 2012 15:55:28 -0800
Subject: [PATCH] ARM: OMAP: irqs: Fix NR_IRQS value to handle PRCM
 interrupts
In-Reply-To: <4F4CD231.4030709@ti.com>
References: <4F4CD231.4030709@ti.com>
Message-ID: <20120228235528.GI18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [120228 04:38]:
> The following commit: 2f31b51659c2d8315ea2888ba5b93076febe672b
> Author: Tero Kristo <t-kristo@ti.com>
> Date:   Fri Dec 16 14:37:00 2011 -0700
> 
>     ARM: OMAP4: PRM: use PRCM interrupt handler
> 
> introduced the PRCM interrupt handler and thus the need
> for 64 more interrupts. Since SPARSE_IRQ is still not fully
> functional on OMAP, the NR_IRQS needs to be updated to avoid
> the failure that happen during irq_alloc_descs call inside
> the PRCM driver:
> 
> [    0.208221] PRCM: failed to allocate irq descs: -12
> 
> Later the mux framework is then unable to request an IRQ from
> the PRCM interrupt handler.
> 
> [    1.802795] mux: Failed to setup hwmod io irq -22
> 
> Fix that by adding 64 more interrupts for OMAP2PLUS config.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
> Tony,
> 
> This patch should probably go for the next -rc if possible.

Thanks applying into fixes as it seems like the only available
fix right now.

Tony
