From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Aug 2011 04:18:05 -0700
Subject: [PATCH] arch:arm:plat-omap:iovmm: remove unused variable 'va'
In-Reply-To: <CAMhs6YwHbFknDpOg9e_5XcB-X9qo+DXX3tAaQy5xQopepeKOxw@mail.gmail.com>
References: <20110808101546.GA25572@maxin>
	<CAMhs6YwHbFknDpOg9e_5XcB-X9qo+DXX3tAaQy5xQopepeKOxw@mail.gmail.com>
Message-ID: <20110810111804.GG1939@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Maxin B John <maxin.john@gmail.com> [110810 04:06]:
> ping.

Sorry I've been on vacation, applying to fixes.

Regards,

Tony

 
> On Mon, Aug 8, 2011 at 1:15 PM, Maxin B. John <maxin.john@gmail.com> wrote:
> > The pointer "va" returned from "phys_to_virt(pa)" is never used in
> > "sgtable_fill_kmalloc()".So,it is safe to remove this set-but-unused variable.
> >
> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> > ---
> > diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> > index c60737c..79e7fed 100644
> > --- a/arch/arm/plat-omap/iovmm.c
> > +++ b/arch/arm/plat-omap/iovmm.c
> > @@ -423,9 +423,6 @@ static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32 da,
> > ?{
> > ? ? ? ?unsigned int i;
> > ? ? ? ?struct scatterlist *sg;
> > - ? ? ? void *va;
> > -
> > - ? ? ? va = phys_to_virt(pa);
> >
> > ? ? ? ?for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> > ? ? ? ? ? ? ? ?unsigned bytes;
> >
