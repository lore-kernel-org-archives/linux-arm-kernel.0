From: anders.grafstrom@netinsight.net (=?ISO-8859-1?Q?Anders_Grafstr=F6m?=)
Date: Sat, 12 Dec 2009 15:01:31 +0100
Subject: [PATCH 2/7] ARM: dma-mapping: simplify page_to_dma()
	and	__pfn_to_bus()
In-Reply-To: <E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
Message-ID: <4B23A23B.7070208@netinsight.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> The non-highmem() and the __pfn_to_bus() based page_to_dma() both
> compile to the same code, so its pointless having these two different
> approaches.  Use the __pfn_to_bus() based version.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/dma-mapping.h |   10 ----------
>  arch/arm/include/asm/memory.h      |    3 ++-
>  2 files changed, 2 insertions(+), 11 deletions(-)

footbridge doesn't build after this.
Could something like the patch below be in order?

diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index cb16e59..cd23276 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -51,6 +51,9 @@ extern unsigned long __bus_to_virt(unsigned long);
 
 #endif
 
+#define __pfn_to_bus(x)		__pfn_to_phys(x)
+#define __bus_to_pfn(x)		__phys_to_pfn(x)
+
 /*
  * Cache flushing area.
  */
