From: cov@codeaurora.org (Christopher Covington)
Date: Tue,  1 Nov 2016 11:10:58 -0600
Subject: [RFC v2 4/7] arm64: Use generic VDSO unmap and remap functions
In-Reply-To: <20161101171101.24704-1-cov@codeaurora.org>
References: <20161101171101.24704-1-cov@codeaurora.org>
Message-ID: <20161101171101.24704-4-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checkpoint/Restore In Userspace (CRIU) must be able to remap and unmap the
Virtual Dynamic Shared Object (VDSO) to be able to handle the changing
addresses that result from address space layout randomization. Now that
generic support is available and arm64 has adopted unsigned long for the
type of mm->context.vdso, opt-in to VDSO unmap and remap support.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 969ef88..534df3f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -50,6 +50,7 @@ config ARM64
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
