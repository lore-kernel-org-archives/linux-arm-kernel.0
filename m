From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 14 Dec 2013 09:27:15 +0400
Subject: [PATCH 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201312071714.25454.arnd@arndb.de>
References: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
 <201312071530.07901.arnd@arndb.de>
 <1386427222.453069261@f379.i.mail.ru>
 <201312071714.25454.arnd@arndb.de>
Message-ID: <20131214092715.6735074a15ce6128d128875f@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 7 Dec 2013 17:14:25 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 07 December 2013, Alexander Shiyan wrote:
> > > > +void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
> > > > +{
> > > > +   BUG_ON(_clps711x_intc_init(NULL, base, size));
> > > > +}
> > > > +EXPORT_SYMBOL(clps711x_intc_init);
> > > 
> > > No need to export this symbol, because you don't call the function from
> > > loadable modules.
> > 
> > OK. I will remove it in the next version by adding "maybe_unused" to this
> > function to avoid possible warnings.
> 
> The __maybe_unused should not be needed, as the function will still have
> global scope.

Arnd can you merge this series with manual EXPORT_SYMBOL removal? Resend?

-- 
Alexander Shiyan <shc_work@mail.ru>
