From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jul 2010 23:05:36 +0100
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100714201149.GA14008@codeaurora.org>
References: <4C3C0032.5020702@codeaurora.org>
	<20100713150311B.fujita.tomonori@lab.ntt.co.jp>
	<20100713121420.GB4263@codeaurora.org>
	<20100714104353B.fujita.tomonori@lab.ntt.co.jp>
	<20100714201149.GA14008@codeaurora.org>
Message-ID: <20100714220536.GE18138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 01:11:49PM -0700, Zach Pfeffer wrote:
> If the DMA-API contained functions to allocate virtual space separate
> from physical space and reworked how chained buffers functioned it
> would probably work - but then things start to look like the VCM API
> which does graph based map management.

Every additional virtual mapping of a physical buffer results in
additional cache aliases on aliasing caches, and more workload for
developers to sort out the cache aliasing issues.

What does VCM to do mitigate that?
