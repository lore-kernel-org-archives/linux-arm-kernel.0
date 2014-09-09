From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 09 Sep 2014 12:06:22 +0900
Subject: [PATCH v2 5/7] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <118816680.lTOkj0TsFJ@wuerfel>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
 <3382034.5ADO0F7naY@wuerfel> <043401cfc794$7f228650$7d6792f0$@samsung.com>
 <118816680.lTOkj0TsFJ@wuerfel>
Message-ID: <02e501cfcbdb$0a95cea0$1fc16be0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Thursday 04 September 2014 01:31:21 Kukjin Kim wrote:
> > > This is the board specific file, so it seems ok.
> > >
> > I mean there are many espresso boards are having different exynos7
> > SoC. I mean exynos7-espresso cannot represent all of espresso boards.
> >
> 
> Ah, I see, that makes sense.
> 
> We definitely need a top-level .dts file for each board that is different
> in a nondiscoverable way then.
> 
Agreed.

And one more, at this moment just using exynos7 would be nice to us then if
required, we could add any specific properties later.

> If the mmc settings and possibly some other nodes (to be added later)
> are common across them, those can be in a board specific .dtsi file.
> 
Yes, right.

> For the memory node, I would actually expect that to be filled by
> the boot loader, so we could leave it out entirely. The same applies
> to the command line: the parts that are in there at the moment (
> "console=ttySAC2,115200n8 root=/dev/ram0 ramdisk=16384 initrd=0x42000000,16M")
> clearly don't belong into a generic dts file and none of them should be
> set that way.
> 
Hmm...yeah we need to use proper boot-loader but I think kernel needs having
default memory property if boot loader doesn't have anything?

> For the initial version, that would mean that the file comes down to having
> as its only contents
> 
> /dts-v1/;
> #include <dt-bindings/gpio/gpio.h>
> #include "exynos7123.dtsi"
> #include "exynos7-espresso.dtsi" // for the mmc nodes
> 
> / {
>        model = "Samsung ESPRESSO board based on EXYNOS7123";
>        compatible = "samsung,espresso", "samsung,exynos7123", "samsung,exynos7";
> };
> 
> One more thing I just noticed is the GPL statement in the dts files.
> Can we please change that to a permissive license in order to allow
> including it in non-GPL boot loaders and operating systems?
> 
> Dual GPL+MIT or GPL+BSD would make most sense here.
> 
I need to check about that with license guy in my team ;)

Naveen, I'll have a look at the patch again.

Thanks,
Kukjin
