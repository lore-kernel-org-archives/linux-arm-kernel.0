From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  5 Jul 2012 14:08:43 -0600
Subject: [PATCH] ARM: fix dummy set/modify_domain() to be inline
Message-ID: <1341518923-20760-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 8026dbe "ARM: fix set_domain() macro" converted some macros to
functions, but forgot to make some of the functions inline. This causes:

arch/arm/include/asm/domain.h:81:13: warning: 'set_domain' defined but not used
arch/arm/include/asm/domain.h:82:13: warning: 'modify_domain' defined but not used

Make the functions inline to avoid this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/include/asm/domain.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 75bd43f..6ddbe44 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -78,8 +78,8 @@ static inline void set_domain(unsigned val)
 	} while (0)
 
 #else
-static void set_domain(unsigned val) { }
-static void modify_domain(unsigned dom, unsigned type)	{ }
+static inline void set_domain(unsigned val) { }
+static inline void modify_domain(unsigned dom, unsigned type)	{ }
 #endif
 
 /*
-- 
1.7.0.4
