From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Thu, 25 Feb 2010 10:51:36 -0500
Subject: External initramfs again ... keep getting "overlaps in-use memory
	region"
Message-ID: <3d1967ab1002250751t1ef512fehf69e3beb7f3f318e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Still trying to get my external initramfs working.

In u-boot, I've tried to tftp my initramfs_data.cpio.gz file to areas
the Kernel uses and area it doesn't know about.

I've unwound things enough to know that the ATAG_MEM's that describe
memory are not passed from u-boot to the kernel (2.6.28).  The kernel
I have is using the "fixup" method to setup 4 banks of DDR (32M each).
 The first bank actually leaves a 16M hole and I've tried to tftp the
cpio.gz there too.

When I use memory that is setup by the kernel fixup, I get the
"overlaps in-use memory region" and when I try to use the 16M region
that isn't included in the fixup I get the "extends beyond physical
memory - disabling initrd" message.

I'm supplying the initrd=<location I tftp cpio.gz to>,<size of
cpio.gz> on the command line.

Do I also need to supply ramdisk_size= and root=/dev/ram0?  Everything
I've read about initramfs says I don't need these or the
CONFIG_BLK_DEV_RAM setting.

Thanks!

Brian
