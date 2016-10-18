From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 18 Oct 2016 06:59:44 +0200
Subject: Bunch of CRC errors in next with arm: move exports to definitions
In-Reply-To: <20160822162512.mptzbiaozx2fz42l@atomide.com>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
Message-ID: <20161018045944.o3j4odeuq4kj6gzx@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2016 at 09:25:13AM -0700, Tony Lindgren wrote:
> Looks like starting with next-20160818 I'm now getting close to
> 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> make modules:
> 
> Building modules, stage 2.
>   MODPOST 399 modules
> WARNING: "__memzero" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "__aeabi_uidivmod" [sound/usb/snd-usb-audio.ko] has no CRC!
> WARNING: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] has no CRC!
> WARNING: "arm_copy_to_user" [sound/usb/snd-usb-audio.ko] has no CRC!
> WARNING: "__aeabi_uidiv" [sound/usb/snd-usb-audio.ko] has no CRC!
> ...
> WARNING: "memset" [crypto/drbg.ko] has no CRC!
> WARNING: "memcpy" [crypto/ctr.ko] has no CRC!
> WARNING: "memcpy" [crypto/cmac.ko] has no CRC!
> WARNING: "__memzero" [crypto/cmac.ko] has no CRC!
> WARNING: "memcpy" [crypto/ccm.ko] has no CRC!
> WARNING: "__memzero" [crypto/ccm.ko] has no CRC!

Any update on this one? I just updated my power-supply next branch
to v4.9-rc1 and now get almost 18000 CRC warnings for allmodconfig.
(I use arm-linux-gnueabihf-gcc (Debian 6.1.1-9) 6.1.1 20160705)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161018/4caf7364/attachment.sig>
