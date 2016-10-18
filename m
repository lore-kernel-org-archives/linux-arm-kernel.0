From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Oct 2016 11:13:31 +0200
Subject: Bunch of CRC errors in next with arm: move exports to definitions
In-Reply-To: <20161018045944.o3j4odeuq4kj6gzx@earth>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
 <20161018045944.o3j4odeuq4kj6gzx@earth>
Message-ID: <6218660.zgecHdOkUb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 18, 2016 6:59:44 AM CEST Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Aug 22, 2016 at 09:25:13AM -0700, Tony Lindgren wrote:
> > Looks like starting with next-20160818 I'm now getting close to
> > 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> > make modules:
> > 
> > Building modules, stage 2.
> >   MODPOST 399 modules
> > WARNING: "__memzero" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > WARNING: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > WARNING: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > WARNING: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > WARNING: "__aeabi_uidivmod" [sound/usb/snd-usb-audio.ko] has no CRC!
> > WARNING: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] has no CRC!
> > WARNING: "arm_copy_to_user" [sound/usb/snd-usb-audio.ko] has no CRC!
> > WARNING: "__aeabi_uidiv" [sound/usb/snd-usb-audio.ko] has no CRC!
> > ...
> > WARNING: "memset" [crypto/drbg.ko] has no CRC!
> > WARNING: "memcpy" [crypto/ctr.ko] has no CRC!
> > WARNING: "memcpy" [crypto/cmac.ko] has no CRC!
> > WARNING: "__memzero" [crypto/cmac.ko] has no CRC!
> > WARNING: "memcpy" [crypto/ccm.ko] has no CRC!
> > WARNING: "__memzero" [crypto/ccm.ko] has no CRC!
> 
> Any update on this one? I just updated my power-supply next branch
> to v4.9-rc1 and now get almost 18000 CRC warnings for allmodconfig.
> (I use arm-linux-gnueabihf-gcc (Debian 6.1.1-9) 6.1.1 20160705)

Nick did a patch to fix this in general, and in powerpc specifically,
I sent a patch yesterday to fix the ARM specific symbols.

	Arnd
