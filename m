From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 08:58:56 +0100
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <AANLkTinVZeaZxt_lWKhjKa0dqhu3_j3BRNySO-2LvMdw@mail.gmail.com>
References: <4C3C0032.5020702@codeaurora.org>
	<20100713150311B.fujita.tomonori@lab.ntt.co.jp>
	<20100713121420.GB4263@codeaurora.org>
	<20100714104353B.fujita.tomonori@lab.ntt.co.jp>
	<20100714201149.GA14008@codeaurora.org>
	<20100714220536.GE18138@n2100.arm.linux.org.uk>
	<20100715012958.GB2239@codeaurora.org>
	<20100715085535.GC26212@n2100.arm.linux.org.uk>
	<AANLkTinVZeaZxt_lWKhjKa0dqhu3_j3BRNySO-2LvMdw@mail.gmail.com>
Message-ID: <20100716075856.GC16124@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 08:48:36PM -0400, Tim HRM wrote:
> Interesting, since I seem to remember the MSM devices mostly conduct
> IO through regions of normal RAM, largely accomplished through
> ioremap() calls.
> 
> Without more public domain documentation of the MSM chips and AMSS
> interfaces I wouldn't know how to avoid this, but I can imagine it
> creates a bit of urgency for Qualcomm developers as they attempt to
> upstream support for this most interesting SoC.

As the patch has been out for RFC since early April on the linux-arm-kernel
mailing list (Subject: [RFC] Prohibit ioremap() on kernel managed RAM),
and no comments have come back from Qualcomm folk.

The restriction on creation of multiple V:P mappings with differing
attributes is also fairly hard to miss in the ARM architecture
specification when reading the sections about caches.
