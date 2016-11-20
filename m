From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Sun, 20 Nov 2016 12:43:38 +0100
Subject: commit 4dd1837d7589f468ed109556513f476e7a7f9121 breaks build
In-Reply-To: <20161120113007.GS1041@n2100.armlinux.org.uk>
References: <58310EC6.4020402@math.uni-bielefeld.de>
 <20161120113007.GS1041@n2100.armlinux.org.uk>
Message-ID: <58318C6A.50104@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,


Russell King - ARM Linux wrote:
> None of the autobuilders are finding this problem, and they build a
> wide range of configurations.  Maybe it's something specific to how
> you're building the kernel - can you give step by step instructions
> how to reproduce this please?
Just using plain make here, no cross-compiler or anything involved. gcc
is version 4.9.4.

Build platform is a Exynos4412 based ODROID-X2.


The complete log from the 'build modules' step:
>   Building modules, stage 2.
>   Kernel: arch/arm/boot/Image is ready
>   MODPOST 52 modules
>   XZKERN  arch/arm/boot/compressed/piggy_data
>   SHIPPED arch/arm/boot/compressed/lib1funcs.S
>   SHIPPED arch/arm/boot/compressed/ashldi3.S
>   SHIPPED arch/arm/boot/compressed/bswapsdi2.S
>   AS      arch/arm/boot/compressed/lib1funcs.o
>   AS      arch/arm/boot/compressed/ashldi3.o
>   AS      arch/arm/boot/compressed/bswapsdi2.o
> ERROR: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> ERROR: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> ERROR: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> ERROR: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_test_and_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_test_and_clear_bit" [sound/core/seq/snd-seq.ko] undefined!
> ERROR: "_test_and_set_bit" [sound/core/seq/snd-seq.ko] undefined!
> ERROR: "_set_bit" [net/bridge/bridge.ko] undefined!
> ERROR: "_clear_bit" [net/bridge/bridge.ko] undefined!
> ERROR: "_test_and_clear_bit" [net/bluetooth/hidp/hidp.ko] undefined!
> ERROR: "_set_bit" [net/bluetooth/hidp/hidp.ko] undefined!
> ERROR: "_clear_bit" [net/bluetooth/hidp/hidp.ko] undefined!
> ERROR: "_set_bit" [net/bluetooth/bnep/bnep.ko] undefined!
> ERROR: "_test_and_set_bit" [net/bluetooth/bnep/bnep.ko] undefined!
> ERROR: "_clear_bit" [net/bluetooth/bnep/bnep.ko] undefined!
> ERROR: "_test_and_clear_bit" [fs/fuse/fuse.ko] undefined!
> ERROR: "_set_bit" [fs/fuse/fuse.ko] undefined!
> ERROR: "_test_and_set_bit" [fs/fuse/fuse.ko] undefined!
> ERROR: "_clear_bit" [fs/fuse/fuse.ko] undefined!
> ERROR: "_test_and_clear_bit" [fs/cifs/cifs.ko] undefined!
> ERROR: "_set_bit" [fs/cifs/cifs.ko] undefined!
> ERROR: "_test_and_set_bit" [fs/cifs/cifs.ko] undefined!
> ERROR: "_clear_bit" [fs/cifs/cifs.ko] undefined!
> ERROR: "_test_and_clear_bit" [fs/btrfs/btrfs.ko] undefined!
> ERROR: "_set_bit" [fs/btrfs/btrfs.ko] undefined!
> ERROR: "_test_and_set_bit" [fs/btrfs/btrfs.ko] undefined!
> ERROR: "_clear_bit" [fs/btrfs/btrfs.ko] undefined!
> ERROR: "_test_and_clear_bit" [drivers/usb/storage/usb-storage.ko] undefined!
> ERROR: "_set_bit" [drivers/usb/storage/usb-storage.ko] undefined!
> ERROR: "_clear_bit" [drivers/usb/storage/usb-storage.ko] undefined!
> ERROR: "_set_bit" [drivers/usb/gadget/libcomposite.ko] undefined!
> ERROR: "_set_bit" [drivers/usb/gadget/function/usb_f_rndis.ko] undefined!
> ERROR: "_test_and_clear_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> ERROR: "_test_and_set_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> ERROR: "_clear_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> ERROR: "_set_bit" [drivers/usb/gadget/function/u_ether.ko] undefined!
> ERROR: "_test_and_clear_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> ERROR: "_set_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> ERROR: "_test_and_set_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> ERROR: "_clear_bit" [drivers/media/platform/s5p-mfc/s5p-mfc.ko] undefined!
> ERROR: "_clear_bit" [drivers/md/dm-crypt.ko] undefined!
> ERROR: "_set_bit" [drivers/md/dm-crypt.ko] undefined!
> ERROR: "_set_bit" [drivers/gpu/arm/mali/maligpu.ko] undefined!
> ERROR: "_clear_bit" [drivers/gpu/arm/mali/maligpu.ko] undefined!
> ERROR: "_test_and_clear_bit" [drivers/bluetooth/btusb.ko] undefined!
> ERROR: "_test_and_set_bit" [drivers/bluetooth/btusb.ko] undefined!
> ERROR: "_set_bit" [drivers/bluetooth/btusb.ko] undefined!
> ERROR: "_clear_bit" [drivers/bluetooth/btusb.ko] undefined!
> ERROR: "_set_bit" [drivers/bluetooth/btintel.ko] undefined!
> ERROR: "_set_bit" [drivers/bluetooth/btbcm.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1191: recipe for target 'modules' failed
> make: *** [modules] Error 2


This is the config I'm using for the build:
https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.9-debug.conf


Let me know which additional information you need.

With best wishes,
Tobias


> On Sun, Nov 20, 2016 at 03:47:34AM +0100, Tobias Jakobi wrote:
>> Hello,
>>
>> this is a resend of my initial mail, see below, to Al Viro (which sadly
>> was ignored).
>>
>> It's rc5 now, and this issue still remains. Putting some more lists on
>> the Cc now.
>>
>> Reverting the commit still works for me.
>>
>>
>> With best wishes,
>> Tobias
>>
>> ----------------
>>
>>
>> Hello Al,
>>
>> compiled a kernel on armv7 with torvalds/master today and getting some
>> errors during the modpost phase.
>>
>>> ERROR: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
>>> ERROR: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
>>> ERROR: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
>>> ERROR: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
>>> ERROR: "_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
>>> ERROR: "_test_and_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
>>> ERROR: "_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
>>> ERROR: "_test_and_clear_bit" [sound/core/seq/snd-seq.ko] undefined!
>> <snip>
>>
>> It seems like the commit 'arm: move exports to definitions' introduces
>> this issue.
>>
>> I quickly went over the commit and I noticed that while it removes the
>> EXPORT_SYMBOL()s for the bitops from armksyms.c, it doesn't move them
>> anywhere.
>>
>> Maybe you can take a look at this?
>>
>> With best wishes,
>> Tobias
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
