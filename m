From: detheridge@ti.com (Darren Etheridge)
Date: Mon, 5 May 2014 13:10:52 -0500
Subject: [PATCH 0/5] irqchip/dra7: crossbar bug fixes
In-Reply-To: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20140505181052.GC2626@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sricharan R <r.sricharan@ti.com> wrote on Mon [2014-May-05 19:48:42 +0530]:
> These are fixes for the crossbar to handle two interrupts getting
> mapped twice to same crossbar and to skip some interrupts being used
> due to hardware bugs.
> 
> Nishanth Menon (5):
>   irqchip: crossbar: dont use '0' to mark reserved interrupts
>   irqchip: crossbar: check for premapped crossbar before allocating
>   irqchip: crossbar: Skip some irqs from getting mapped to crossbar
>   irqchip: crossbar: Initialise the crossbar with a safe value
>   irqchip: crossbar: Change allocation logic by reversing search for
>     free irqs
> 
Looks good!

I tested this patch series (plus the necessary dts changes) on a
DRA7xx-EVM with the work in progress VIP driver which needs a crossbar
mapping otherwise it won't get any interrupts (using 3.15-rc4 kernel).
It boots cleanly and interrupts are firing for VIP, so everything
working for me.

Without this patch series I can't even get the DRA7xx EVM to boot with
IRQ crossbar support enabled so this is a big improvement.

Tested-by: Darren Etheridge <detheridge@ti.com>


>  drivers/irqchip/irq-crossbar.c |   82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 8 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
