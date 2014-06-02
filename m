From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 02 Jun 2014 08:24:34 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIEFSTTogaS5NWDogYXZpYzogVXNlIGlycWNoaXBf?=
 =?UTF-8?B?aW5pdCgpIGZvciBJUlEgaW5pdGlhbGl6YXRpb24gaW4gRFQgY2FzZQ==?=
In-Reply-To: <20140602022120.GL8860@dragon>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
 <20140602022120.GL8860@dragon>
Message-ID: <1401683074.224894202@f141.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 2 Jun 2014 10:21:21 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> On Sat, May 31, 2014 at 10:01:30AM +0400, Alexander Shiyan wrote:
> > Use generic irqchip_init() DT call to initialize IRQs, so after this patch,
> > the mxc-avic driver is quite prepared to move to drivers/irqchip.
> 
> What's the whole plan of the moving?  IOW, what's left after this patch
> and what's the plan for those?

For the full movement of these drivers into drivers/irqchip, we need to find a
solution for i.MX specific functions, such as mxc_set_irq_fiq() and
tzic_enable_wake(). I haven't found a good solution yet...

> > As a temporary solution to do it, we use OF_DECLARE_2()
> 
> I do not see OF_DECLARE_2() is defined anywhere?

<include/linux/of.h>

---
