From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Mar 2014 17:09:11 +0100
Subject: [PATCH 3/7] of: introduce of_dma_is_coherent() helper
In-Reply-To: <531948A8.9040106@ti.com>
References: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
 <CAL_JsqJ3QhRRNVAsvAPP=Ex_ptQcbpCXh7pf44K1xh+scFqiug@mail.gmail.com>
 <531948A8.9040106@ti.com>
Message-ID: <201403071709.11568.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 March 2014, Santosh Shilimkar wrote:
> On Friday 07 March 2014 11:55 AM, Rob Herring wrote:
>
> > Thinking about this some more, if the arch is always coherent or
> > always non-coherent, then the default ops are always fine. In that
> > case set_arch_dma_coherent_ops is always a nop and of_dma_is_coherent
> > is a don't care.
> > 
> Hmmm.. I guess you are right. In that case we can drop the need of
> config option.

A compile-time config option clearly would not work here, because it
breaks multiplatform support when some platforms are different from
others. I can still see the possible need for a global run-time setting
though, to give some platform init code the ability to override the
DT flags when it knows better. That is probably what you want to do
on keystone without LPAE.

	Arnd
