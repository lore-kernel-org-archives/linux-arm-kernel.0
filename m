From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 3 Apr 2012 10:23:56 +0200 (CEST)
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <20120402225223.GN24211@n2100.arm.linux.org.uk>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
 <20120402225223.GN24211@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1204031022030.2542@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Apr 2012, Russell King - ARM Linux wrote:
> If we want to fix it a better way, then sure, that'll be good.  But what
> we shouldn't do is re-introduce one regression to fix a different
> regression.
> 
> So, Thomas, what do you think about providing a way that a disabled
> interrupt could have its pending status cleared such that when it's
> enabled, any queued events are ignored?  Maybe an enable_and_clear_irq() ?
 
We can make it a flag, which you can either add to the irq itself or
hand it in on request_irq().

Does that require a special chip->callback() function as well ?

Thanks,

	tglx
