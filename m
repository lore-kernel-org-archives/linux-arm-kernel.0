From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 9 Jun 2013 11:24:40 +0200
Subject: N900 device tree conversion: how to do first step
In-Reply-To: <20130609015944.GA23559@amd.pavel.ucw.cz>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
Message-ID: <201306091124.41251@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013 03:59:44 Pavel Machek wrote:
> Hi!
> 
> I'd like to convert Nokia N900 to device tree.
> 
> Unfortunately, serial port is not easily available (very
> special cable would be needed, does someone know where to get
> one?) and I don't have BDI (and very special cable would be
> needed, too).
> 

Hello,

I used serial port only in qemu for debugging. Maybe you can try
to play with qemu first. Qemu has good n900 HW support.

But problematic is to create n900 mtd nand image bootable in
qemu, because it needs closed source nokia bootloader and this
needs to have CAL partition with some unknown data with is
proprietary format.

Nevertheless, there is prebuilded qemu image with maemo5 and with
special version of nokia patches qemu, which was (and still is)
very good for testing anything for n900. Special version of qemu
plus qemu image is part of MADDE development tool, look here:

Info: http://wiki.maemo.org/MADDE
Download link: http://tablets-dev.nokia.com/MADDE.php

Except skinning support and Opengl ES all other nokia patches were
included into Linaro version of qemu, so you can use it without
problems. But you still need proprietary bootloader and correct
CAL partition.

But, nokia released closed redistributable version of bootloader
for qemu and (proprietary) tool which generating mtd nand
partition. You can pass kernel, initfs, rootfs images and it
create correct mtd layout and automatically creating CAL.

Proprietary n900 bootloader (two parts!) for qemu is here:
http://download.meego.com/live/Trunk:/non-oss:/Testing/Trunk_Testing/i586/nolo-qemu-0.20100910-1.2.i586.rpm

Proprietary tool for creating mtd nand file is here:
http://download.meego.com/live/Trunk:/non-oss:/Testing/Trunk_Testing/i586/qflasher-21-1.2.i586.rpm

PS: Sorry for too many closed SW, but there is no FOSS equivalent
and this is the only one option how to use qemu n900 hw support.
U-Boot is ported to n900, but depends on Nokia bootloader...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130609/e7737340/attachment-0001.sig>
