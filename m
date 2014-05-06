From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 May 2014 17:48:33 -0700
Subject: [PATCH 0/5] irqchip/dra7: crossbar bug fixes
In-Reply-To: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20140506004833.GP25949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [140505 07:20]:
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
>  drivers/irqchip/irq-crossbar.c |   82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 8 deletions(-)

Thanks applying all into omap-for-v3.16/crossbar.

Tony
