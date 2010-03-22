From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Mar 2010 10:08:54 +0100
Subject: Can physical flash initramfs cpio address be given to bootm?
In-Reply-To: <20100319123616.GC21280@n2100.arm.linux.org.uk>
References: <3d1967ab1003171209j43a9a005l4be5d2faf38fec31@mail.gmail.com>
	<20100319123616.GC21280@n2100.arm.linux.org.uk>
Message-ID: <20100322090854.GB10684@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Mar 19, 2010 at 12:36:16PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 17, 2010 at 03:09:14PM -0400, Brian Hutchinson wrote:
> > Can I use the physical flash address of a initramfs with the u-boot
> > bootm command?  The kernel doesn't appear to like it .... see below.
> 
> bootm has nothing to do with the kernel, so I think you want to ask
> this question on a different (uboot?) mailing list.
> 
> > When I do a bootm 0x20080000 (physical flash location of kernel)
> > 0x20280000 (mkimage of cpio.gz made with -T ramdisk) the physical
> > flash address of the initramfs gets passed to kernel via ATAGS and the
> > kernel doesn't like it:
> > 
> > INITRD: 0x20280040+0x00c8bdb6 extends beyond physical memory - disabling initrd
> 
> The initrd image must be in RAM; there's no getting around this because
> the kernel wants to convert addresses to struct page pointers and other
> magical stuff like that which can only be done with RAM.
Is this a problem of the implementation or a techical one?  Some time
ago we hit the same problem and IIRC it was only that the memory was
allocated before unpacking and freed at the end.  If that's the only
issue than we can skip it if the initrd lives outside RAM!?
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
