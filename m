From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Aug 2013 15:05:44 +0100
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching
 for 64 bit physical addresses
In-Reply-To: <51FCFBE1.5090000@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1308022156120.14472@syhkavp.arg> <51FCFBE1.5090000@ti.com>
Message-ID: <20130803140544.GB23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 03, 2013 at 06:17:29PM +0530, Sricharan R wrote:
>   I started with this kind of augmenting with the immediate operand
>   while starting V2. But the problem was, we do the runtime patching twice.

It might be much better to do this only once, and instead of having the
early code overwrite the page table in use, create a new page table with
all the correct page table entries in and switch to that.

This also has the added advantage that there's no longer a page table at
a known fixed address which may be useful to attackers.
