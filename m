From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Apr 2012 19:38:13 +0100
Subject: [PATCH 4/4] ARM: remove consistent dma region and use common
 vmalloc range for dma allocations
In-Reply-To: <1334325950-7881-5-git-send-email-m.szyprowski@samsung.com>
References: <1334325950-7881-1-git-send-email-m.szyprowski@samsung.com>
 <1334325950-7881-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120413183813.GO24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 04:05:50PM +0200, Marek Szyprowski wrote:
> This patch changes dma-mapping subsystem to use generic vmalloc areas
> for all consistent dma allocations. This increases the total size limit
> of the consistent allocations and removes platform hacks and a lot of
> duplicated code.

NAK.  I don't think you appreciate the contexts from which the dma coherent
code can be called from, and the reason why we pre-allocate the page
tables (so that IRQ-based allocations work.)

The vmalloc region doesn't allow that because page tables are allocated
using GFP_KERNEL not GFP_ATOMIC.

Sorry.
