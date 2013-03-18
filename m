From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 18 Mar 2013 09:56:07 +0100 (CET)
Subject: [PATCH 2/2] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <5146C95C.3000509@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
 <1363376175-22312-3-git-send-email-gerlando.falauto@keymile.com>
 <alpine.LFD.2.02.1303152101080.22263@ionos>
 <5146C95C.3000509@keymile.com>
Message-ID: <alpine.LFD.2.02.1303180954470.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Mar 2013, Gerlando Falauto wrote:
> On 03/15/2013 09:47 PM, Thomas Gleixner wrote:
> You're right... and I appreciate you NOT using such words. :-)

I try hard :)
 
> Just one question:
> 
> > 	bool mskperct = flags & IRQ_GC_SEPARATE_MASK_REGISTERS;
> > 	bool mskinit = flags & IRQ_GC_INIT_MASK_CACHE;
> > 	u32 *shmsk = &gc->shared_mask_cache;
> > 
> > 	if (!mskperct && mskinit)
> > 	     	*shmsk = irq_reg_readl(gc->reg_base + ct->regs.mask);
> > 
> > 	for (i = 0; i < gc->num_ct: i++, ct++) {
> > 	       ct->pmask_cache = mskperct ? &ct->mask_cache : shmsk;
> 
> What is wrong with using ct[i] instead? I find it a bit more readable.

Either way is fine. I like the pointers more, but that's my personal
preference and I let you chose whatever you want

Thanks,

	tglx
