From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 7 Dec 2009 13:31:41 +0200
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091206141601.GB28932@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de> <4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
Message-ID: <c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I ran it on an ARM926EJ-S, which is ARMv5 and worked fine.
>
does it have L2 cache?
> If there's no problem with C=0 B=1 mappings on Kirkwood, I've no idea
> what's going on, and I don't have any suggestion on what to try next.
>
> The log shows that the kernel is doing the right thing: when we detect
> two mappings for the same page in the same MM space, we clean and
> invalidate any existing cacheable mappings visible in the MM space
> (both L1 and L2), and switch all visible mappings to C=0 B=1 mappings.
> This makes the area non-cacheable.
what about the PTE of the MM space of the write process? if it remains
C=1 B=1, then it's data will be at the L2, and as the L2 is not
flushed on context switch, then that explains this behavior.
