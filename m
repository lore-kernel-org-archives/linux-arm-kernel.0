From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 23 Jan 2015 22:39:55 +0100
Subject: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Message-ID: <201501232239.55801@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

when I boot zImage with appended DT n900 in qemu fdt_open_into() 
function called from file arch/arm/boot/compressed/atags_to_fdt.c 
(in function atags_to_fdt) always returns -FDT_ERR_NOSPACE.

It means that all ATAGS (including cmdline arguments) passed by 
bootloader are ignored.

On real n900 device I see that booted DT version also ignore 
cmdline arguments from bootloader. I cannot debug decompress code 
on real device, but I think it is same problem as in qemu.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/382d9ddf/attachment.sig>
