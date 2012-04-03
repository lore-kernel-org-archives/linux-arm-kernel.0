From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 3 Apr 2012 10:20:58 +0200 (CEST)
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <1333406005.30734.61.camel@pasglop>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
Message-ID: <alpine.LFD.2.02.1204031019320.2542@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Apr 2012, Benjamin Herrenschmidt wrote:

> On Mon, 2012-04-02 at 22:55 +0100, Russell King - ARM Linux wrote:
> > Well, presumably someone is calling irq_set_irq_type() asking explicitly
> > for IRQ_TYPE_NONE.  The code will now (as it always used to before David's
> > change) do exactly what you ask this to: it will ask the type to be set
> > to none.
> > 
> > If you don't want to set the type to none, don't call the interface asking
> > for that to happen. 
> 
> I think part of the idea with NONE is to use it as "reset that interrupt
> to the "default" setting, whatever that means ...

Well, the ship side set_type function could simply leave it alone and
not touch the thing at all. That's how the core code did until we
discovered that we broke Russells toys that way.

Thanks,

	tglx
