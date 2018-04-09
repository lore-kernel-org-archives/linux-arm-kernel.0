From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Mon, 9 Apr 2018 00:35:49 +0000
Subject: [PATCH AUTOSEL for 3.18 040/101] arm64: pass machine size to sparse
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
Message-ID: <20180409003505.164715-40-alexander.levin@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit f5d284900c0f960e318a063f4c40826b6e3aa6a8 ]

When using sparse on the arm64 tree we get many thousands of
warnings like 'constant ... is so big it is unsigned long long'
or 'shift too big (32) for type unsigned long'. This happens
because by default sparse considers the machine as 32bit and
defines the size of the types accordingly.

Fix this by passing the '-m64' flag to sparse so that
sparse can correctly define longs as being 64bit.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 37c4fd6aeb7a..3e2f6590666a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -32,7 +32,7 @@ AS		+= -EL
 LD		+= -EL
 endif
 
-CHECKFLAGS	+= -D__aarch64__
+CHECKFLAGS	+= -D__aarch64__ -m64
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
 KBUILD_CFLAGS_MODULE	+= -mcmodel=large
-- 
2.15.1
