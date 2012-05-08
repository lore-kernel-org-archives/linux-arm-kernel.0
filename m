From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 May 2012 22:55:54 +0100
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
In-Reply-To: <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com>
 <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
Message-ID: <20120508215554.GA18980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 07:31:57PM +0530, Shilimkar, Santosh wrote:
> Ok. Assuming you mean " it's _not_ cleaner to have two domains where
> manager overrides XN attributes" Note that DRAM can be in the middle of
> 4GB address space, so we need to take care of bottom and top address
> space.
> 
> Update patch end of the email. Is that fine with you ?

This is certainly not cleaner because this will break non-ARMv7.
