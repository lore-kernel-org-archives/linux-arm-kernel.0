From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Dec 2012 18:48:28 +0000
Subject: [RFC PATCH] ARM: Consider memblocks in mem_init and show_mem.
In-Reply-To: <1355334000-10198-1-git-send-email-steve.capper@arm.com>
References: <1355334000-10198-1-git-send-email-steve.capper@arm.com>
Message-ID: <20121212184828.GD14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 05:40:00PM +0000, Steve Capper wrote:
> One consequence of using memblocks in show_mem, is that we are
> unable to define ARCH_DISCARD_MEMBLOCK.

That's true anyway, because we use it for pfn_valid(), which gets used
for ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM.
