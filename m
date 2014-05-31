From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 31 May 2014 23:53:47 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRkNdIEFSTTogY2xwczcxMXg6IFBhcnRpYWwgbXVsdGlw?=
 =?UTF-8?B?bGF0Zm9ybSBzdXBwb3J0?=
In-Reply-To: <13452733.Lg1kBhJLHP@wuerfel>
References: <1401559206-23767-1-git-send-email-shc_work@mail.ru>
 <13452733.Lg1kBhJLHP@wuerfel>
Message-ID: <1401566027.546285143@f356.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 31 May 2014 20:12:21 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> On Saturday 31 May 2014 22:00:06 Alexander Shiyan wrote:
> > This patch provide initial partial multiplatform support for CLPS711X CPUs.
> > Not intended for apply, just for comments at now.
...
> One technicality: this change breaks all defconfig files and user
> .configs. You can avoid that if you keep the name ARCH_CLPS711X for
> either the single- or the multiplatform case and name the common
> option ARCH_CLPS711X_COMMON.

arch/arm/Kconfig:303:error: recursive dependency detected!
arch/arm/Kconfig:303:   choice <choice> contains symbol ARCH_CLPS711X
arch/arm/Kconfig:388:   symbol ARCH_CLPS711X is part of choice CLPS711X_MULTI
arch/arm/mach-clps711x/Kconfig:12:      symbol CLPS711X_MULTI depends on ARCH_MULTI_V4T
arch/arm/Kconfig:874:   symbol ARCH_MULTI_V4T depends on ARCH_MULTIPLATFORM
arch/arm/Kconfig:308:   symbol ARCH_MULTIPLATFORM is part of choice <choice>

So, it is so hard to keep ARCH_CLPS711X in its original state...

---
