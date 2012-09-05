From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Sep 2012 09:51:25 -0700
Subject: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
In-Reply-To: <CAMQu2gxGtLzOWWsBAimW=8tE5Dd9GvOs63rKvfcsNB4X1wqLxw@mail.gmail.com>
References: <20120905000309.GW1303@atomide.com> <50473A67.6000805@ti.com>
 <CAMQu2gxGtLzOWWsBAimW=8tE5Dd9GvOs63rKvfcsNB4X1wqLxw@mail.gmail.com>
Message-ID: <20120905165125.GC1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120905 06:17]:
> On Wed, Sep 5, 2012 at 5:11 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> >
> > Hi Tony,
> >
> > On 09/05/2012 02:03 AM, Tony Lindgren wrote:
> > > If NR_IRQS is less than MAX_IRQS, we end up writing past the
> > > irq_target_cpu array in omap_wakeupgen_init():
> > >
> > > /* Associate all the IRQs to boot CPU like GIC init does. */
> > > for (i = 0; i < max_irqs; i++)
> > >       irq_target_cpu[i] = boot_cpu;
> > >
> > > This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
> > > set to 16. Without this patch we're overwriting other data during
> > > the boot.
> >
> > In fact I already sent a patch to fix that when I started my SPARSE_IRQ
> > cleanup, but it looks like it was never merged :-(
> > I guess I forgot a little bit that series.
> >
> Indeed. I remember acking few patches in that series.
> Infact this patch set was the basis on which I was talking to Arnd
> that SPARSE_IRQ
> should work on OMAP. Didn't think that it has not made it yet in mainline.

Bummer. That means duplicate wasted effort was done :(

Looks like the original patch no longer applies because of commit
247c445c0 (ARM: OMAP5: Add the WakeupGen IP updates). So I'll just
update the comments to mention Benoit's original patch.

I guess the lesson here is that everybody must follow up on their own
patches to make sure they get merged. Especially on fixes.

Benoit, can you please check if some parts of your earlier series are
still needed in the testing-cleanup branch?

BTW, there was also Felipe's TWL removal patch that was done in a slightly
different way "[PATCH] arm: omap: drop unused IRQ defines:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/103274.html# 

Regards,

Tony
