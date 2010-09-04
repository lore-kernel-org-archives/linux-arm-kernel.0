From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 4 Sep 2010 04:13:10 +0200
Subject: [PATCH] ARM: expose PB1176 ROM in debugfs
In-Reply-To: <AANLkTik4F8VnCota=Jp+pZPg3QHvr-dKzy3cuVXJeMu7@mail.gmail.com>
References: <1278504339-26992-1-git-send-email-triad@df.lth.se>
	<AANLkTilxaHzHC3zFPR6q9v2mGKu7EG_Nv40V0kcZ-gwR@mail.gmail.com>
	<AANLkTik4F8VnCota=Jp+pZPg3QHvr-dKzy3cuVXJeMu7@mail.gmail.com>
Message-ID: <201009040413.10445.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 3. z??? 2010 23:38:54 Linus Walleij napsal(a):
> Ping on this David, you have an opinion? debugfs ROM or
> MTD ROM mapping?

Hey, I'd be for having this exposed through mtd_rom too. Cheers
> 
> Yours,
> Linus Walleij
> 
> 2010/7/18 Linus Walleij <linus.ml.walleij@gmail.com>:
> > 2010/7/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> On Wed, Jul 07, 2010 at 02:05:39PM +0200, Linus Walleij wrote:
> >>> This exposes the PB1176 ROM as a simple 16KiB file in debugfs so
> >>> that it can be copied out and disassembled with some
> >>> objcopy+objdump massage for example. I used this to find out how
> >>> the ROM handled the CharLCD.
> >> 
> >> Would it be better to expose this through a mtd ROM mapping (map_rom) ?
> > 
> > This is more convenient I think.
> > 
> > I don't know the actual purpose of MTD ROM mappings, so
> > paging David on this.
> > 
> > It has the small upside of only getting compiled in if you select
> > CONFIG_DEBUG_FS, and getting a distinct name in debugfs
> > rather than /dev/mtdN.
> > 
> > Also I can now cp /debugfs/pb1176-ROM foo.bin
> > Is this possible with mtdblocks or do you have to dd if=... ?
> > 
> > Yours,
> > Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
