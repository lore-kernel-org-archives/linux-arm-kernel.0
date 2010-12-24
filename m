From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:23:59 +0000
Subject: [PATCH 0/6] PL011 DMA support
Message-ID: <20101224102359.GC20587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-post of the previous set, but using writew() instead of writew_relaxed().
writew_relaxed() is not part of the MMIO accessor API, and so should
not be used in drivers which may be used on other architectures.

Also copying Dan for his review of the DMA engine use.
