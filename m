From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Jun 2013 18:12:22 -0700
Subject: [PATCH v2] ARM: exynos: add debug_ll_io_init() call in
 exynos_init_io()
In-Reply-To: <09ca01ce6244$e2f0e7a0$a8d2b6e0$%kim@samsung.com>
References: <1370397539-21653-1-git-send-email-dianders@chromium.org>
 <1370465793-7997-1-git-send-email-dianders@chromium.org>
 <CAOesGMhQX9ip=nb9AQa5fcDFRNpZZSxUO0N0GTX051dakWZD9Q@mail.gmail.com>
 <09ca01ce6244$e2f0e7a0$a8d2b6e0$%kim@samsung.com>
Message-ID: <20130608011222.GC27436@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 08:32:04AM +0900, Kukjin Kim wrote:
> Olof Johansson wrote:
> > 
> > On Wed, Jun 5, 2013 at 1:56 PM, Doug Anderson <dianders@chromium.org>
> > wrote:
> > > If the early MMU mapping of the UART happens to get booted out of the
> > > TLB between the start of paging_init() and when we finally re-add the
> > > UART at the very end of s3c_init_cpu(), we'll get a hang at bootup if
> > > we've got early_printk enabled.  Avoid this hang by calling
> > > debug_ll_io_init() early.
> > >
> > > Without this patch, you can reliably reproduce a hang when early
> > > printk is enabled by adding flush_tlb_all() at the start of
> > > exynos_init_io().  After this patch the hang goes away.
> > >
> > > Signed-off-by: Doug Anderson <dianders@chromium.org>
> > 
> > Acked-by: Olof Johansson <olof@lixom.net>
> > 
> > 
> > Kukjin, this seems appropriate for 3.10. Do you have other fixes
> > queued or should I apply this directly?
> > 
> If I remember correctly, nothing in my tree for 3.10.
> 
> So please go ahead with my ack if you want,
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 

Applied for 3.10 (together with the uncompress.h fix from Tushar)


-Olof
