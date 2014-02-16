From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 16 Feb 2014 23:06:55 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXJtOiBpbXg6IHJlbW92ZSBNQUNIX01YTEFEUw==?=
In-Reply-To: <1392576223.28866.24.camel@x220>
References: <1392573811.28866.22.camel@x220>
 <1392574562.956803244@f244.i.mail.ru>
 <1392576223.28866.24.camel@x220>
Message-ID: <1392577615.265469392@f161.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 16 ??????? 2014, 19:43 +01:00 ?? Paul Bolle <pebolle@tiscali.nl>:
> On Sun, 2014-02-16 at 22:16 +0400, Alexander Shiyan wrote:
> > ???????????, 16 ??????? 2014, 19:03 +01:00 ?? Paul Bolle
> <pebolle@tiscali.nl>:
> > > The Kconfig symbol MACH_MXLADS was added in v2.6.29. It has never been
> > > used. Setting it has no effect. There are no calls for
> > > machine_is_mxlads(). This symbol can safely be removed.
> > > 
> > > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > 
> > This is used by mach-mx1ads.c
> 
> How is it used?

Kconfig selects MACH_MXLADS, this enables machine_arch_type
from include/generated/mach-types.h which used for machine_is_xx() macro,
so if multiple boards is defined in the kernel, this cause to incorrect matching.
Russel, Arnd, fixme.

---
