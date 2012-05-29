From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 13:29:32 +0100
Subject: [GIT PULL] CMA and ARM DMA-mapping updates for v3.5
In-Reply-To: <1337672417-10065-1-git-send-email-m.szyprowski@samsung.com>
References: <1337672417-10065-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120529122932.GA24623@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I notice we have new warnings as a result of CMA being merged, though
thankfully they're just in Kconfig:

warning: (ARM) selects CMA which has unmet direct dependencies (HAVE_DMA_CONTIGUOUS && HAVE_MEMBLOCK && EXPERIMENTAL)

This seems totally weird: you're mandating that ARM must have CMA
selected, but it's an experimental feature?  So you're implying that
the entire ARM kernel becomes totally experimental for the next
release cycle?

I think this needs fixing.
