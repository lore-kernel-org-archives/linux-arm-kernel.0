From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 19:09:13 +0000
Subject: External initramfs again ... keep getting "overlaps in-use
	memory region"
In-Reply-To: <3d1967ab1002250814q27ed0798l7e250f80c0db3fdb@mail.gmail.com>
References: <3d1967ab1002250751t1ef512fehf69e3beb7f3f318e@mail.gmail.com>
	<3d1967ab1002250814q27ed0798l7e250f80c0db3fdb@mail.gmail.com>
Message-ID: <20100225190913.GC3101@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 11:14:22AM -0500, Brian Hutchinson wrote:
> ... it looks like I'm getting the overlap message because my fixup
> routine has already setup memory and then my initrd comes along and
> reserve_bootmem_node tries to set the region to BOOTMEM_EXCLUSIVE.

Give us all the information:

- where exactly your memory is located and how large
- where you've tried putting your initrd image, and how large this is
- how large your uncompressed kernel is, and where it's located
- how large the compressed kernel is, and where you're loading it
- the kernel messages

Just describing what's going on without numbers doesn't give enough
clues to work out why you're having a problem.
