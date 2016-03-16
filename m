From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Mar 2016 14:18:02 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <56E95A4E.4050709@codeaurora.org>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
Message-ID: <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 08:06:22AM -0500, Timur Tabi wrote:
> Will Deacon wrote:
> >You could look into making ARCH_DMA_MINALIGN a runtime value, but that
> >looks like an uphill struggle to me. Alternatively, we could only warn
> >if the CWG is bigger than L1_CACHE_BYTES *and* we have a non-coherent
> >DMA master, but that doesn't solve any performance issues from having
> >things like locks sharing cachelines, not that I think we ever got any
> >data on that (afaik, we don't pad locks to cacheline boundaries anyway).
> >I'm also not sure what it would mean for PCI NoSnoop transactions.
> 
> Our internal version of this patch made it a Kconfig option.  Perhaps that
> would at least be an improvement over just reverting it?  We already have to
> have our own defconfig for the QDF2432.

Why do you need your own defconfig? If it's just on the short term until
all your code is upstream, that's fine, but this goes against the single
Image aim. I would like defconfig to cover all supported SoCs (and yes,
ACPI on by default once we deem it !EXPERT anymore), though at some
point we may need a server/mobile split (if the generated image is too
large, maybe more stuff being built as modules).

-- 
Catalin
