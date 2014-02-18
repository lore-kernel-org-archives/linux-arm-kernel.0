From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Feb 2014 11:45:42 -0700
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <1663692.UxtD9eTEBL@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <2312919.pM61KLBcYY@wuerfel>
 <20140218174125.GC29304@obsidianresearch.com>
 <1663692.UxtD9eTEBL@wuerfel>
Message-ID: <20140218184542.GA22004@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 07:25:35PM +0100, Arnd Bergmann wrote:

> Apple have also used the same trick on their G5 Macs, presumably
> to simplify things for OS9 and OS-X, but even at the time making
> it harder for Linux.

I actually think some x86's have done the same thing, however the
firmware hides all that from the OS and the OS just sees a normal PCI
environment. So if we can't hide the mess in firmware, the next best
place is in drivers?

> Do we even need stable domain numbers? If we do, aliases sound fine.
> A more complex method would be to sort them by MMIO window address
> or perhaps by phandle.

PCI ordering has been a bane in the past on x86, so I think stable
domain numbers is certainly desirable. Particularly since the domain
number may be influenced by module load order :( Alises followed by
sorting by phandle sounds great to me.

Jason
