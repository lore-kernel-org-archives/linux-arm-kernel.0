From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 18 Dec 2013 20:35:29 +0400
Subject: [PATCH 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201312141331.39372.arnd@arndb.de>
References: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
 <201312071714.25454.arnd@arndb.de>
 <20131214092715.6735074a15ce6128d128875f@mail.ru>
 <201312141331.39372.arnd@arndb.de>
Message-ID: <20131218203529.67d4ae281ca265d94e24d064@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 14 Dec 2013 13:31:39 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

...
> > > > > > +void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
> > > > > > +{
> > > > > > +   BUG_ON(_clps711x_intc_init(NULL, base, size));
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(clps711x_intc_init);
> > > > > 
> > > > > No need to export this symbol, because you don't call the function from
> > > > > loadable modules.
> > > > 
> > > > OK. I will remove it in the next version by adding "maybe_unused" to this
> > > > function to avoid possible warnings.
> > > 
> > > The __maybe_unused should not be needed, as the function will still have
> > > global scope.
> > 
> > Arnd can you merge this series with manual EXPORT_SYMBOL removal? Resend?
> 
> I'm still traveling at the moment and will only be resuming my normal arm-soc
> work in January. All arm-soc patches are handled by Olof and Kevin still,
> and irqchip patches go through Thomas anyway (or can get merged through arm-soc
> with his Ack in case of dependencies).

We do not have a separate mailing list for irqchip drivers, so at this time I
just re-send an updated patchset as v2 with Thomas in CC.

-- 
Alexander Shiyan <shc_work@mail.ru>
