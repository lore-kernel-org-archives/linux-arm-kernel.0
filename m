From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 27 Oct 2016 08:39:37 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
Message-ID: <20161027143937.GC6818@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 10:50:48AM +0200, Matthias Brugger wrote:
> >+		/* Sanity check the proposed bitstream. It must start with the
> >+		 * sync word in the correct byte order and be a multiple of 4
> >+		 * bytes.
> >+		 */
> >+		if (count <= 4 || buf[0] != 0x66 || buf[1] != 0x55 ||
> >+		    buf[2] != 0x99 || buf[3] != 0xaa) {
>
> This checks if the bit stream is bigger then 4 bytes. We error out before,
> if it is smaller.

We do? Where?

> So you should fix the wording in the comment and check for count ==
> 4.

Ah right, the comment reflected an earlier revision that had the
length check here.

The count <= 4 should stay here since it is primarily guarding against
read past the buffer in the if.

Jason
