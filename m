From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 May 2012 04:04:51 -0700
Subject: Wrong location of omap_writel?
In-Reply-To: <3426836.dn1rYLBNLa@dizzy-6>
References: <3426836.dn1rYLBNLa@dizzy-6>
Message-ID: <20120528110451.GB12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* David Lanzend?rfer <david.lanzendoerfer@o2s.ch> [120528 02:07]:
> Hi
> 
> Under linux-next 20120528
> 
> I've just found "omap_writel" within "arch/arm/plat-omap/include/plat/usb.h"...
> Shouldn't it be located within "arch/arm/plat-omap/include/plat/io.h"?
> 
> Just some logical question.
> It looks somehow wrong to me...

It's in usb.h as the legacy full speed usb code is the only remaining user
for omap_read/write for omap2+.

I've also posted a series that removes the legacy full speed usb code and
omap_read/write for omap2+ for v3.6 merge window.

Regards,

Tony
