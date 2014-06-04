From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Jun 2014 23:29:33 +0200
Subject: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
In-Reply-To: <20140604125137.GA18171@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <3061297.feg5DGUjIt@vostro.rjw.lan> <20140604125137.GA18171@lee--X1>
Message-ID: <1603851.9SBouhvdWS@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 04, 2014 01:51:37 PM Lee Jones wrote:
> On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
> 
> > On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > > Any drivers which support ACPI and Device Tree probing need to include
> > > both respective header files.  Without this patch, if a driver is being
> > > used on a platform which does not support ACPI and subsequently does not
> > > have the config option enabled, but includes linux/acpi.h the build
> > > breaks with:
> > > 
> > >   In file included from ../include/acpi/platform/acenv.h:150:0,
> > >                    from ../include/acpi/acpi.h:56,
> > >                    from ../include/linux/match.h:2,
> > >                    from ../drivers/i2c/i2c-core.c:43:
> > >   ../include/acpi/platform/aclinux.h:73:23:
> > >    fatal error: asm/acenv.h: No such file or directory
> > >    #include <asm/acenv.h>
> > >                        ^
> > 
> > Which kernel does this happen with?
> 
> a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
>   Add linux-next specific files for 20140602

It looks like the problem is with include/linux/match.h that should not
include acpi/acpi.h directly.

But I can't find this file in the Linus' next branch even, so I guess it's
on its way to that branch?

Rafael
