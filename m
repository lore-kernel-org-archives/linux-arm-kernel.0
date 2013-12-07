From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 07 Dec 2013 19:20:16 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBhc206IGFkZCByZWFkcS93cml0ZXEgbWV0aG9k?=
 =?UTF-8?B?cw==?=
In-Reply-To: <yw1xlhzwlmp3.fsf@unicorn.mansr.com>
References: <52A32C88.9010000@arkona-technologies.de>
 <yw1xlhzwlmp3.fsf@unicorn.mansr.com>
Message-ID: <1386429616.205081304@f164.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Matthias Mann <M.Mann@arkona-technologies.de> writes:
> 
> > Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
> > PCIe as a single transfer.
> >
> > Signed-off-by: Matthias Mann <m.mann@arkona-technologies.de>
> > ---
> > This patch creates checkpatch warnings, but I used the style used for the
> > existing functions.
> > It is based on branch next/soc of the arm-soc tree.
> >
> >  arch/arm/include/asm/io.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > index 3c597c2..0a8d015 100644
> > --- a/arch/arm/include/asm/io.h
> > +++ b/arch/arm/include/asm/io.h
> > @@ -94,6 +94,13 @@ static inline void __raw_writel(u32 val, volatile void __iomem *addr)
> >  		     : "r" (val));
> >  }
> >
> > +static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > +{
> > +	asm volatile("strd %1, %0"

Fixme, how this will work for ARMv4? Is this supported for systems above v5te
or I missed something?

---
