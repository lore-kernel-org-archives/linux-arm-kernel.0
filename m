From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Apr 2011 08:26:16 +0100
Subject: MT_HIGH_VECTOR mapping set read-only creating illegal access
In-Reply-To: <4DA4F170.4020009@codeaurora.org>
References: <4DA4F170.4020009@codeaurora.org>
Message-ID: <20110413072616.GJ7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 05:42:24PM -0700, Michael Bohan wrote:
> Hi,
>
> In arch/arm/kernel/traps.c:set_tls() and arch/arm/include/asm/tls.h,  
> some configurations allow for a assignment of address 0xffff0ff0. This  
> address falls within the MT_HIGH_VECTORS mapping setup in  
> devicemaps_init(). That mapping is explicitly made read-only. Thus, the  
> kernel takes a segfault when writing in set_tls().
>
> It looks like this disparity may have been introduced in this commit:
>
> commit 36bb94ba36f332de767cfaa3af6a5136435a3a9c
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Tue Nov 16 08:40:36 2010 +0000
>
>     ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Is there a reason this mapping must be read-only? Perhaps we could apply  
> write access for these special cases only?

Have you checked the behaviour immediately before this commit, and the
behaviour with this commit applied?
