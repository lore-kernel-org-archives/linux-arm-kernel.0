From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 13 Sep 2012 15:28:11 +0100
Subject: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
In-Reply-To: <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913125347.GD2470@linaro.org>
 <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
Message-ID: <20120913142810.GD20420@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 02:01:35PM +0100, Shilimkar, Santosh wrote:
> On Thu, Sep 13, 2012 at 6:23 PM, Dave Martin <dave.martin@linaro.org> wrote:

[...]

> > LoUIS matches the power domain affected by turning a single CPU off
> > on most (all?) current v7 SoCs where this matters, but only by coincidence.
> > There is no guarantee of that.
> >
> > The _louis() API is useful, because this is exactly what you need to to
> > I-/D-/TLB synchronisation in an SMP OS.  Using it as preparation for
> > powering a CPU off feels like misuse, at least in theory.
> >
> > For powerdown, we would logically need a separate function,
> > flush_cache_cpu() or something, whose job is precisely to flush those
> > levels which will be affected by the power-down if that single CPU.
> >
> In the series, there is patch "[PATCH 3/6]" which adds an
> API which let you operate on a specific level.

Yep, but that's not callable from __cpu_suspend_save in a generic way
(it is v7 specific and we are not going to add another API/macro for
that to be usable in generic code, at least for now).

Let's keep that patch in our trees and as Russell suggested we will repost it
with the PM BSP accordingly to raise the point and take it from there.

Thanks,
Lorenzo
