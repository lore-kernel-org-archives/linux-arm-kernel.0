From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 2 Apr 2018 14:20:15 -0400 (EDT)
Subject: [PATCH v3 5/6] Initialize the mapping of KASan shadow memory
In-Reply-To: <20180402181536.GJ16141@n2100.armlinux.org.uk>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
 <20180402120440.31900-6-liuwenliang@huawei.com>
 <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr>
 <20180402181536.GJ16141@n2100.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.1804021418220.28462@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Apr 2018, Russell King - ARM Linux wrote:

> On Mon, Apr 02, 2018 at 02:08:13PM -0400, Nicolas Pitre wrote:
> > On Mon, 2 Apr 2018, Abbott Liu wrote:
> > 
> > > index c79b829..20161e2 100644
> > > --- a/arch/arm/kernel/head-common.S
> > > +++ b/arch/arm/kernel/head-common.S
> > > @@ -115,6 +115,9 @@ __mmap_switched:
> > >  	str	r8, [r2]			@ Save atags pointer
> > >  	cmp	r3, #0
> > >  	strne	r10, [r3]			@ Save control register values
> > > +#ifdef CONFIG_KASAN
> > > +	bl	kasan_early_init
> > > +#endif
> > >  	mov	lr, #0
> > >  	b	start_kernel
> > >  ENDPROC(__mmap_switched)
> > 
> > Would be better if lr was cleared before calling kasan_early_init.
> 
> No.  The code is correct - please remember that "bl" writes to LR.

You're right of course.

/me giving up on patch review and going back to bed


Nicolas
