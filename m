From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 9 Nov 2009 11:42:54 +0100
Subject: dream: fastboot getting protocol errors
In-Reply-To: <20091109103602.GC2207@elf.ucw.cz>
References: <20091109103602.GC2207@elf.ucw.cz>
Message-ID: <20091109104254.GA8757@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2009-11-09 11:36:02, Pavel Machek wrote:
> Hi!
> 
> I'm still fighting with porting MMC support to current mainline.
> 
> Meanwhile: I'm getting this *way* too often -- with the htcUSB  to
> 2xUSB reduction. Any ideas?
> 
> root at amd:/data/l/android# ./fastboot -c "console=tty0
> root=/dev/mmcblk0p1 rootdelay=5 fbcon=rotate:1" boot
> /data/l/linux-msm/arch/arm/boot/zImage
> creating boot image...
> creating boot image - 1667072 bytes
> downloading 'boot.img'... FAILED (command write failed (Protocol
> error))
> root at amd:/data/l/android# 
> 
> ...and then it just goes away after powercycling the phone...

And this is another failure mode: display says "FASTBOOT", and serial
console says

UART0:Cmd>szCPLDstrlen=0x5

+usbloader_init
-usbloader_init


(but no message about usb highspeed mode), and fastboot hangs with 

root at amd:/data/l/android# ./fastboot -c "console=tty0
root=/dev/mmcblk0p1 rootdelay=5 fbcon=rotate:1" boot
/data/l/linux-dream-mainline/arch/arm/boot/zImage
creating boot image...
creating boot image - 1421312 bytes
< waiting for device >

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
