From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 May 2018 11:19:09 +0300
Subject: [PATCH 24/24] arm64: ilp32: Make the Kconfig option default y
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
Message-ID: <20180516081910.10067-25-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

The intention of the ILP32 branches is to enable ILP32 by default. This
default is to be revisited for upstream merging.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a3134b8e3123..3551990a2726 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1249,6 +1249,7 @@ config AARCH32_EL0
 
 config ARM64_ILP32
 	bool "Kernel support for ILP32"
+	default y
 	help
 	  This option enables support for AArch64 ILP32 user space.  ILP32
 	  is an ABI where long and pointers are 32bits but it uses the AARCH64
-- 
2.17.0
