From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 25 Nov 2010 13:48:17 +0300
Subject: [PATCH v2 2/3] ARM: cns3xxx: Add architecture definition for
	EHCI/OHCI controller
In-Reply-To: <AANLkTimMEALmH08RKQet_MGiyEFYpD2kVtPtmKJpmhtZ@mail.gmail.com>
References: <1290443565-20766-1-git-send-email-mkl0301@gmail.com>
	<1290443565-20766-3-git-send-email-mkl0301@gmail.com>
	<20101124161122.GA15902@oksana.dev.rtsoft.ru>
	<AANLkTimMEALmH08RKQet_MGiyEFYpD2kVtPtmKJpmhtZ@mail.gmail.com>
Message-ID: <20101125104817.GA31779@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 03:25:38PM +0800, Lin Mac wrote:
[...]
> > ?#include <linux/module.h>
> > ?#include <linux/io.h>
> > ?#include <linux/delay.h>
> > +#include <asm/atomic.h>
> It's not necessary for mach/pm.h already included it, right?

Technically, it's not necessary. But in Linux we don't rely on
headers including other headers. Think that someday mach/pm.h
may not include asm/atomic.h, so the build will break.

Thanks,

> 
> > ?#include <mach/system.h>
> > ?#include <mach/cns3xxx.h>
> > ?#include <mach/pm.h>
> > @@ -117,3 +118,6 @@ int cns3xxx_cpu_clock(void)
> > ? ? ? ?return cpu;
> > ?}
> > ?EXPORT_SYMBOL(cns3xxx_cpu_clock);
> > +
> > +atomic_t usb_pwr_ref = ATOMIC_INIT(0);
> > +EXPORT_SYMBOL(usb_pwr_ref);

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
