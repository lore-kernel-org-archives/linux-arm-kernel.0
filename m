From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 07 Dec 2013 20:27:12 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIEFSTTogY2xwczcxMXg6IEFkZCBDTFBTNzExWCBp?=
 =?UTF-8?B?cnFjaGlwIGRyaXZlcg==?=
In-Reply-To: <201312071714.25454.arnd@arndb.de>
References: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
 <1386427222.453069261@f379.i.mail.ru>
 <201312071714.25454.arnd@arndb.de>
Message-ID: <1386433632.720292283@f382.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

OK. Then, if additional comments not appears, I will ask you to apply this
series and remove EXPORT() during the merge. I was remind of this in a week.

---
