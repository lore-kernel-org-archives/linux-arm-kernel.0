From: Barry.Song@csr.com (Barry Song)
Date: Tue, 15 Jan 2013 14:45:11 +0800
Subject: [PATCH 1/2] ARM: 7114/1: cache-l2x0: add missed dummy outer_resume
 entry
Message-ID: <1358232311-20355-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

commit 91c2ebb90b1890a adds resume entry for l2 in secure mode,
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;h=91c2ebb
but it misses the dummy entry when CONFIG_CACHE_L2X0 is not set.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/include/asm/outercache.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 53426c6..12f71a1 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -92,6 +92,7 @@ static inline void outer_flush_range(phys_addr_t start, phys_addr_t end)
 static inline void outer_flush_all(void) { }
 static inline void outer_inv_all(void) { }
 static inline void outer_disable(void) { }
+static inline void outer_resume(void) { }
 
 #endif
 
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
