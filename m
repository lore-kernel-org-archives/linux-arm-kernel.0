From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Aug 2016 16:27:46 +0100
Subject: [PATCH 7/7] arm64: Enable CONFIG_ARM64_TTBR0_PAN
In-Reply-To: <1471015666-23125-1-git-send-email-catalin.marinas@arm.com>
References: <1471015666-23125-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1471015666-23125-8-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Kconfig option to enable support for TTBR0 PAN. The
option is default off because of a slight performance hit when enabled,
caused by the additional TTBR0_EL1 switching during user access
operations or exception entry/exit code.

Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 69c8787bec7d..e7d5d0a7f6b4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -784,6 +784,14 @@ config SETEND_EMULATION
 	  If unsure, say Y
 endif
 
+config ARM64_TTBR0_PAN
+	bool "Priviledged Access Never using TTBR0_EL1 switching"
+	help
+	  Enabling this option prevents the kernel from accessing
+	  user-space memory directly by pointing TTBR0_EL1 to a reserved
+	  zeroed area and reserved ASID. The user access routines
+	  restore the valid TTBR0_EL1 temporarily.
+
 menu "ARMv8.1 architectural features"
 
 config ARM64_HW_AFDBM
