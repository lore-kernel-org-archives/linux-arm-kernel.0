From: imre.deak@nokia.com (imre.deak at nokia.com)
Date: Mon, 29 Mar 2010 19:17:39 +0300
Subject: [RFC PATCH v3 2/3] ARM: VFP: make user_vfp struct packed
In-Reply-To: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
Message-ID: <36fcf42798b64339f0a3f259dc6b034719049031.1269878482.git.imre.deak@nokia.com>
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
