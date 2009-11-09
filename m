From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 9 Nov 2009 14:13:41 +0100
Subject: dream: fastboot getting protocol errors
In-Reply-To: <a55d774e0911090459q2e373b5bw9f4fafe71e631c70@mail.gmail.com>
References: <20091109103602.GC2207@elf.ucw.cz>
	<a55d774e0911090459q2e373b5bw9f4fafe71e631c70@mail.gmail.com>
Message-ID: <20091109131340.GB23292@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2009-11-09 04:59:10, Brian Swetland wrote:
> On Mon, Nov 9, 2009 at 2:36 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > I'm still fighting with porting MMC support to current mainline.
> >
> > Meanwhile: I'm getting this *way* too often -- with the htcUSB ?to
> > 2xUSB reduction. Any ideas?
> >
> > root at amd:/data/l/android# ./fastboot -c "console=tty0
> > root=/dev/mmcblk0p1 rootdelay=5 fbcon=rotate:1" boot
> > /data/l/linux-msm/arch/arm/boot/zImage
> > creating boot image...
> > creating boot image - 1667072 bytes
> > downloading 'boot.img'... FAILED (command write failed (Protocol
> > error))
> > root at amd:/data/l/android#
> >
> > ...and then it just goes away after powercycling the phone...
> 
> Unfortunately, I think that's just flakies in the htc bootloader.  I'm
> not aware of any simple workaround.  Do you not see it fail if you use
> a straight USB A->miniB cable?

No, that seems to work reliably.

> I think that bootloader will still honor a secondstage bootloader
> embedded in the boot.img (mkbootimg --second foo), or you could
> replace the zimage in the boot.img with a second stage bootloader.
> Either way, dunno if you want to dig into bootloader hackery to try to
> resolve usb issues.

Ok, so its time to simply retry until it works...

Thanks for info!
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
