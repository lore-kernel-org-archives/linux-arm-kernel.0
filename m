From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 21 Nov 2010 06:47:20 +0200
Subject: [PATCH] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
In-Reply-To: <4CE6B27D.2000909@bvs-tech.com>
References: <20101117160514.GA5308@n2100.arm.linux.org.uk>
	<4CE6B27D.2000909@bvs-tech.com>
Message-ID: <20101121044720.GA6088@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexis,

On Fri, Nov 19, 2010 at 06:23:09PM +0100, Alexis RODET wrote:
> > It would, however, be nice if _someone_ out there could produce a patch
> Here is the patch and here is the command line used for doing this:

You need to CC the MTD maintainer and mailing list (David Woodhouse 
<dwmw2@infradead.org>, and linux-mtd at lists.infradead.org respectively), and 
maybe also the SPI subsystem maintainers (David Brownell 
<dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, 
spi-devel-general at lists.sourceforge.net).

baruch

> find . \( -name .git -prune -false -o -path \
> ./include/linux/spi/flash.h \ -o \( -name \*.c -execdir grep -q \
> '#include <linux/spi/flash.h>' \{\} \; \) \) -execdir sed -i -e \
> 's/struct flash_platform_data/struct spi_flash_platform_data/' \
> \{\} \+ -execdir git add \{\} \+ -print
> 
> I didn't test all compilations as I don't have blackfin compiler installed.
> I compiled successfully for x86 with allyesconfig and for Freescale mx27
> with allmodconfig minus some incompatible drivers.

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
