From: lv.zheng@intel.com (Zheng, Lv)
Date: Thu, 5 Jun 2014 01:01:17 +0000
Subject: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
In-Reply-To: <1603851.9SBouhvdWS@vostro.rjw.lan>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <3061297.feg5DGUjIt@vostro.rjw.lan> <20140604125137.GA18171@lee--X1>
 <1603851.9SBouhvdWS@vostro.rjw.lan>
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026203F6@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: linux-i2c-owner at vger.kernel.org [mailto:linux-i2c-owner at vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Thursday, June 05, 2014 5:30 AM
> 
> On Wednesday, June 04, 2014 01:51:37 PM Lee Jones wrote:
> > On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
> >
> > > On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > > > Any drivers which support ACPI and Device Tree probing need to include
> > > > both respective header files.  Without this patch, if a driver is being
> > > > used on a platform which does not support ACPI and subsequently does not
> > > > have the config option enabled, but includes linux/acpi.h the build
> > > > breaks with:
> > > >
> > > >   In file included from ../include/acpi/platform/acenv.h:150:0,
> > > >                    from ../include/acpi/acpi.h:56,
> > > >                    from ../include/linux/match.h:2,
> > > >                    from ../drivers/i2c/i2c-core.c:43:
> > > >   ../include/acpi/platform/aclinux.h:73:23:
> > > >    fatal error: asm/acenv.h: No such file or directory
> > > >    #include <asm/acenv.h>
> > > >                        ^
> > >
> > > Which kernel does this happen with?
> >
> > a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
> >   Add linux-next specific files for 20140602
> 
> It looks like the problem is with include/linux/match.h that should not
> include acpi/acpi.h directly.

This is another example that many mis-ordered inclusions are caused by the mis-ordered <asm/acpi.h> inclusion.

> 
> But I can't find this file in the Linus' next branch even, so I guess it's
> on its way to that branch?
> 

I guess,
In their tree, they have CONFIG_ACPI enabled for ARM, but we've changed to make:
1. <asm/acenv.h> the architecture specific layer for ACPICA, and
2. <asm/acpi.h> is now the architecture specific layer for Linux ACPI.
So they need to follow this.

Thanks and best regards
-Lv

> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
