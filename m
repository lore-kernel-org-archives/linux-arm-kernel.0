From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 5 Sep 2012 10:28:45 +0530
Subject: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
In-Reply-To: <20120905000309.GW1303@atomide.com>
References: <20120905000309.GW1303@atomide.com>
Message-ID: <CAMQu2gx5aojH1mzDV-QfqLFJsm3CTf=NLK0ZNVkjYAk6YBKYtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2012 at 5:33 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> If NR_IRQS is less than MAX_IRQS, we end up writing past the
> irq_target_cpu array in omap_wakeupgen_init():
>
> /* Associate all the IRQs to boot CPU like GIC init does. */
> for (i = 0; i < max_irqs; i++)
>         irq_target_cpu[i] = boot_cpu;
>
> This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
> set to 16. Without this patch we're overwriting other data during
> the boot.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
