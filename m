From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Mar 2010 12:36:16 +0000
Subject: Can physical flash initramfs cpio address be given to bootm?
In-Reply-To: <3d1967ab1003171209j43a9a005l4be5d2faf38fec31@mail.gmail.com>
References: <3d1967ab1003171209j43a9a005l4be5d2faf38fec31@mail.gmail.com>
Message-ID: <20100319123616.GC21280@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 03:09:14PM -0400, Brian Hutchinson wrote:
> Can I use the physical flash address of a initramfs with the u-boot
> bootm command?  The kernel doesn't appear to like it .... see below.

bootm has nothing to do with the kernel, so I think you want to ask
this question on a different (uboot?) mailing list.

> When I do a bootm 0x20080000 (physical flash location of kernel)
> 0x20280000 (mkimage of cpio.gz made with -T ramdisk) the physical
> flash address of the initramfs gets passed to kernel via ATAGS and the
> kernel doesn't like it:
> 
> INITRD: 0x20280040+0x00c8bdb6 extends beyond physical memory - disabling initrd

The initrd image must be in RAM; there's no getting around this because
the kernel wants to convert addresses to struct page pointers and other
magical stuff like that which can only be done with RAM.

> How do you all load a initramfs from flash???

You have to copy it into RAM first.  I don't know how to tell uboot to
do that, I'm not a uboot expert.
