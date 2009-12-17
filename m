From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 Dec 2009 10:07:27 -0700
Subject: [RFC PATCH] arm: add big-endian versions of io{read, write}{16,
	32}be() macros
Message-ID: <20091217170324.24211.92910.stgit@angua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added so that existing drivers already using the io*be() macros will
compile.  A specific example is the xilinx_spi.c driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/arm/include/asm/io.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d2a59cf..1fb772a 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -240,10 +240,14 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define ioread8(p)	({ unsigned int __v = __raw_readb(p); __v; })
 #define ioread16(p)	({ unsigned int __v = le16_to_cpu((__force __le16)__raw_readw(p)); __v; })
 #define ioread32(p)	({ unsigned int __v = le32_to_cpu((__force __le32)__raw_readl(p)); __v; })
+#define ioread16be(p)	({ unsigned int __v = be16_to_cpu((__force __be16)__raw_readw(p)); __v; })
+#define ioread32be(p)	({ unsigned int __v = be32_to_cpu((__force __be32)__raw_readl(p)); __v; })
 
 #define iowrite8(v,p)	__raw_writeb(v, p)
 #define iowrite16(v,p)	__raw_writew((__force __u16)cpu_to_le16(v), p)
 #define iowrite32(v,p)	__raw_writel((__force __u32)cpu_to_le32(v), p)
+#define iowrite16be(v,p)	__raw_writew((__force __u16)cpu_to_be16(v), p)
+#define iowrite32be(v,p)	__raw_writel((__force __u32)cpu_to_be32(v), p)
 
 #define ioread8_rep(p,d,c)	__raw_readsb(p,d,c)
 #define ioread16_rep(p,d,c)	__raw_readsw(p,d,c)
