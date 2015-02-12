From: arnd@arndb.de (arnd at arndb.de)
Date: Thu, 12 Feb 2015 21:08:10 +0100 (CET)
Subject: [PATCH 03/11] ARM: BCM: put back ARCH_MULTI_V7 dependency for
 mobile
In-Reply-To: <CAGVrzcZREV5O1ui3KjwdZVBtBaAByUz7GpstMeAARXs0XCra6w@mail.gmail.com>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-4-git-send-email-arnd@arndb.de>
 <CAGVrzcZREV5O1ui3KjwdZVBtBaAByUz7GpstMeAARXs0XCra6w@mail.gmail.com>
Message-ID: <925335687.498462.1423771690391.JavaMail.open-xchange@oxbaltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Florian Fainelli <f.fainelli@gmail.com> hat am 12. Februar 2015 um 21:02
> geschrieben:
> 2015-02-12 11:42 GMT-08:00 Arnd Bergmann <arnd@arndb.de>:
> > A recent cleanup rearranged the Kconfig file for mach-bcm and
> > accidentally dropped the dependency on ARCH_MULTI_V7, which
> > makes it possible to now build the two mobile SoC platforms
> > on an ARMv6-only kernel, resulting in a log of Kconfig
> > warnings like
> >
> > warning: ARCH_BCM_MOBILE selects ARM_ERRATA_775420 which has unmet direct
> > dependencies (CPU_V7)
> >
> > and which of course cannot work on any machine.
> >
> > This puts back the dependencies as before.
>
> Since both of these Kconfig options also select ARCH_BCM_MOBILE, you
> could put the select there instead?

No, that would only work with 'select', but we need 'depends on' here.

    Arnd
