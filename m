From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 15:48:19 +0000
Subject: [PATCH v4 15/19] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <1297783609.23889.6.camel@e102144-lin.cambridge.arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
	<20110212102803.GC15616@n2100.arm.linux.org.uk>
	<1297770742.21448.2.camel@e102144-lin.cambridge.arm.com>
	<20110215123522.GH4152@n2100.arm.linux.org.uk>
	<1297773569.14691.36.camel@e102109-lin.cambridge.arm.com>
	<1297777027.1293.2.camel@e102144-lin.cambridge.arm.com>
	<20110215142339.GL4152@n2100.arm.linux.org.uk>
	<1297783609.23889.6.camel@e102144-lin.cambridge.arm.com>
Message-ID: <20110215154819.GO4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 03:26:49PM +0000, Will Deacon wrote:
> The conflict with the p2v branch is fairly hefty, but something like
> this should do (if you're happy I'll submit it to replace 6670/1):

I was thinking that was the case - which is why I wanted this split up
so this can be tackled separately.

> Note that because the v2p macros only work for lowmem, I've not bothered
> to add casts for the __v2p macros (rather, I've just changed the types
> of the static inline functions). This simplifies the code and means we
> can stay clear of the runtime fixup stuff.

This patch looks good enough, thanks.
