From: davem@davemloft.net (David Miller)
Date: Tue, 09 Mar 2010 02:20:15 -0800 (PST)
Subject: DMA using data buffer vmapped in kernel space
In-Reply-To: <20100309101611.GC5691@n2100.arm.linux.org.uk>
References: <20100309091403.GB5691@n2100.arm.linux.org.uk>
	<20100309.012935.98310472.davem@davemloft.net>
	<20100309101611.GC5691@n2100.arm.linux.org.uk>
Message-ID: <20100309.022015.162981335.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 9 Mar 2010 10:16:11 +0000

> It looks like the firmware interface may return a pointer to either the
> kernel binary itself for built-in firmware, or to a set of pages which
> have been vmap'd.  In the former case, vmalloc_to_page() will fail.

Indeed, then you're right, the firmware layer would need to provide
the interface since only it knows where the memory is.

However, there's also no real portable way to compute physical
addresses from kernel image virtual addresses.

BTW, it's been my experience that drivers copy the firmware into a
locally allocated buffer exactly to avoid this problem.
