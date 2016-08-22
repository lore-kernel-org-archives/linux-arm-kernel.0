From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Aug 2016 09:25:13 -0700
Subject: Bunch of CRC errors in next with arm: move exports to definitions
Message-ID: <20160822162512.mptzbiaozx2fz42l@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

Looks like starting with next-20160818 I'm now getting close to
800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
make modules:

Building modules, stage 2.
  MODPOST 399 modules
WARNING: "__memzero" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
WARNING: "__aeabi_uidivmod" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "arm_copy_to_user" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "__aeabi_uidiv" [sound/usb/snd-usb-audio.ko] has no CRC!
...
WARNING: "memset" [crypto/drbg.ko] has no CRC!
WARNING: "memcpy" [crypto/ctr.ko] has no CRC!
WARNING: "memcpy" [crypto/cmac.ko] has no CRC!
WARNING: "__memzero" [crypto/cmac.ko] has no CRC!
WARNING: "memcpy" [crypto/ccm.ko] has no CRC!
WARNING: "__memzero" [crypto/ccm.ko] has no CRC!

Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
fixes it.

Regards,

Tony
