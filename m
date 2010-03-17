From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Wed, 17 Mar 2010 15:09:14 -0400
Subject: Can physical flash initramfs cpio address be given to bootm?
Message-ID: <3d1967ab1003171209j43a9a005l4be5d2faf38fec31@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can I use the physical flash address of a initramfs with the u-boot
bootm command?  The kernel doesn't appear to like it .... see below.

I'm currently loading my cpio initramfs into u-boot via tftp and then
providing the initrd= bootarg which works now that I've changed my
memory model to sparsemem (Thanks Russell!).

I've tried to wrap the cpio with mkimage both with -a 0x0 -e 0x0 and a
RAM address such as -a 0x4000000 -e 0x4000000 (the location I tftp the
initramfs to)

When I do a bootm 0x20080000 (physical flash location of kernel)
0x20280000 (mkimage of cpio.gz made with -T ramdisk) the physical
flash address of the initramfs gets passed to kernel via ATAGS and the
kernel doesn't like it:

INITRD: 0x20280040+0x00c8bdb6 extends beyond physical memory - disabling initrd

I thought I saw a patch that allowed initramfs to come from physical
media (flash) but it looks like I currently have to copy the initramfs
to ram right now and provide the initrd= which I would like to get
away from since I don't want to have to touch u-boot env vars every
time the cpio changes.

How do you all load a initramfs from flash???

Regards,

Brian
