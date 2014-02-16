From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 16 Feb 2014 23:21:04 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXJtOiBpbXg6IHJlbW92ZSBNQUNIX01YTEFEUw==?=
In-Reply-To: <1392577965.28866.37.camel@x220>
References: <1392573811.28866.22.camel@x220>
 <1392577615.265469392@f161.i.mail.ru>
 <1392577965.28866.37.camel@x220>
Message-ID: <1392578464.996901773@f49.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 16 ??????? 2014, 20:12 +01:00 ?? Paul Bolle <pebolle@tiscali.nl>:
> On Sun, 2014-02-16 at 23:06 +0400, Alexander Shiyan wrote:
> > Kconfig selects MACH_MXLADS, this enables machine_arch_type
> > from include/generated/mach-types.h which used for machine_is_xx() macro,
> > so if multiple boards is defined in the kernel, this cause to incorrect
> matching.
> 
> But, as I stated in the commit explanation, there are no users of
> machine_is_mxlads().

If you have MXLADS and FOO boards support in the kernel (for example)
and you want to start MXLADS version, your machine_is_FOO() will be positive,
since machine_arch_type will be constant value FOO in this case.

---
