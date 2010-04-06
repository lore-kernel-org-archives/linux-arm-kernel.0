From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Apr 2010 23:08:17 +0100
Subject: [PATCH] arm: mm: Don't free prohibited memmap entries
In-Reply-To: <1270506861-14461-1-git-send-email-mbohan@codeaurora.org>
References: <> <1270506861-14461-1-git-send-email-mbohan@codeaurora.org>
Message-ID: <20100406220817.GE12831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 05, 2010 at 03:34:21PM -0700, Michael Bohan wrote:
> From: Michael Bohan <mbohan@quicinc.com>
> 
> The VM subsystem assumes that there are valid memmap entries to
> the bank end aligned to MAX_ORDER_NR_PAGES. It will try and read
> these page structs, and so we cannot free any memmap entries that
> it may inspect.

1. are you enabling ARCH_HAS_HOLES_MEMORYMODEL ?
2. where does it try to access these page structs without trying
   pfn_valid() to check whether a page struct exists first?
