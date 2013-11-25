From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Nov 2013 23:20:03 +0000
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131125223636.GA20822@obsidianresearch.com>
References: <20131125223636.GA20822@obsidianresearch.com>
Message-ID: <20131125232003.GU16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:36:36PM -0700, Jason Gunthorpe wrote:
> Which is after your new inlines..
> 
> An elegant fix wasn't obvious to me :)

Same here... it's all rather complicated because of all those ifdefs.
Nothing easy comes to mind about how to fix this one.  I'll look into
it at some point.

If not, it's going to have to be a revert - or we bite the bullet and
start killing off some of these Kconfig options such as making
ARM_PATCH_PHYS_VIRT mandatory.
