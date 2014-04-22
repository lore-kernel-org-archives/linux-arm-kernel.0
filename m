From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 20:45:39 +0200
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140422183855.GZ24070@n2100.arm.linux.org.uk>
References: <534D0D91.8020406@linaro.org> <15350123.PBHzyiOlX4@wuerfel>
 <20140422183855.GZ24070@n2100.arm.linux.org.uk>
Message-ID: <8603980.izkPFxMbQ5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 19:38:55 Russell King - ARM Linux wrote:
> On Tue, Apr 22, 2014 at 08:32:10PM +0200, Arnd Bergmann wrote:
> > @@ -1943,6 +1953,7 @@ config DEPRECATED_PARAM_STRUCT
> >  # TEXT and BSS so we preserve their values in the config files.
> >  config ZBOOT_ROM_TEXT
> >       hex "Compressed ROM boot loader base address"
> > +     depends on BROKEN_MULTIPLATFORM
> >       default "0"
> >       help
> >         The physical address at which the ROM-able zImage is to be
> > @@ -1954,6 +1965,7 @@ config ZBOOT_ROM_TEXT
> >  
> >  config ZBOOT_ROM_BSS
> >       hex "Compressed ROM boot loader BSS address"
> > +     depends on BROKEN_MULTIPLATFORM
> >       default "0"
> >       help
> >         The base address of an area of read/write memory in the target
> 
> Please get rid of the above changes.

Good point, fixed now.

	Arnd
