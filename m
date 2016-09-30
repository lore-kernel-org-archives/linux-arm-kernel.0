From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Fri, 30 Sep 2016 17:26:09 +0800
Subject: [PATCH v4 2/2] arm64 Kconfig: Select gigantic page
In-Reply-To: <1475227569-63446-1-git-send-email-xieyisheng1@huawei.com>
References: <1475227569-63446-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <1475227569-63446-3-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 supports gigantic page after
commit 084bd29810a5 ("ARM64: mm: HugeTLB support.")
however, it can only be allocated at boottime and can't be freed.

This patch selects ARCH_HAS_GIGANTIC_PAGE to make gigantic pages
can be allocated and freed at runtime for arch arm64.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..92217f6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-- 
1.7.12.4
