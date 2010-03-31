From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Thu,  1 Apr 2010 00:23:25 +0300
Subject: [RFC PATCH v4 2/3] ARM: VFP: make user_vfp struct packed
In-Reply-To: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
References: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
Message-ID: <4df1d126213d8f321e932f85a4ddf3bbbfd7ea03.1270066971.git.imre.deak@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Imre Deak <imre.deak@nokia.com>

An upcoming patch will include user_vfp as a member in another struct and
this will cause the next member to be 8 byte aligned as well. Since the
struct is part of an ABI it's better not leave such alignment decisions
to the compiler.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/include/asm/user.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/user.h b/arch/arm/include/asm/user.h
index df95e05..5660777 100644
--- a/arch/arm/include/asm/user.h
+++ b/arch/arm/include/asm/user.h
@@ -88,6 +88,6 @@ struct user{
 struct user_vfp {
 	unsigned long long fpregs[32];
 	unsigned long fpscr;
-};
+} __attribute__((packed));
 
 #endif /* _ARM_USER_H */
-- 
1.7.0.2
