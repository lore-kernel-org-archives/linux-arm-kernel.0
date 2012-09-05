From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 5 Sep 2012 18:46:34 +0530
Subject: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
In-Reply-To: <50473A67.6000805@ti.com>
References: <20120905000309.GW1303@atomide.com> <50473A67.6000805@ti.com>
Message-ID: <CAMQu2gxGtLzOWWsBAimW=8tE5Dd9GvOs63rKvfcsNB4X1wqLxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2012 at 5:11 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>
> Hi Tony,
>
> On 09/05/2012 02:03 AM, Tony Lindgren wrote:
> > If NR_IRQS is less than MAX_IRQS, we end up writing past the
> > irq_target_cpu array in omap_wakeupgen_init():
> >
> > /* Associate all the IRQs to boot CPU like GIC init does. */
> > for (i = 0; i < max_irqs; i++)
> >       irq_target_cpu[i] = boot_cpu;
> >
> > This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
> > set to 16. Without this patch we're overwriting other data during
> > the boot.
>
> In fact I already sent a patch to fix that when I started my SPARSE_IRQ
> cleanup, but it looks like it was never merged :-(
> I guess I forgot a little bit that series.
>
Indeed. I remember acking few patches in that series.
Infact this patch set was the basis on which I was talking to Arnd
that SPARSE_IRQ
should work on OMAP. Didn't think that it has not made it yet in mainline.

Regards
Santosh
