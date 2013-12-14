From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Dec 2013 13:31:39 +0100
Subject: [PATCH 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <20131214092715.6735074a15ce6128d128875f@mail.ru>
References: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
 <201312071714.25454.arnd@arndb.de>
 <20131214092715.6735074a15ce6128d128875f@mail.ru>
Message-ID: <201312141331.39372.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 December 2013, Alexander Shiyan wrote:
> On Sat, 7 Dec 2013 17:14:25 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Saturday 07 December 2013, Alexander Shiyan wrote:
> > > > > +void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
> > > > > +{
> > > > > +   BUG_ON(_clps711x_intc_init(NULL, base, size));
> > > > > +}
> > > > > +EXPORT_SYMBOL(clps711x_intc_init);
> > > > 
> > > > No need to export this symbol, because you don't call the function from
> > > > loadable modules.
> > > 
> > > OK. I will remove it in the next version by adding "maybe_unused" to this
> > > function to avoid possible warnings.
> > 
> > The __maybe_unused should not be needed, as the function will still have
> > global scope.
> 
> Arnd can you merge this series with manual EXPORT_SYMBOL removal? Resend?

I'm still traveling at the moment and will only be resuming my normal arm-soc
work in January. All arm-soc patches are handled by Olof and Kevin still,
and irqchip patches go through Thomas anyway (or can get merged through arm-soc
with his Ack in case of dependencies).

	Arnd
