From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 6 Apr 2016 01:08:32 +0300
Subject: [PATCH 10/25] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.

>From now, AARCH32_EL0 (former COMPAT) config option means the support of
AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
and COMPAT indicates that one of them, or both, is enabled.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..f923687 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -925,6 +925,10 @@ menu "Userspace binary formats"
 source "fs/Kconfig.binfmt"
 
 config COMPAT
+	def_bool y
+	depends on AARCH32_EL0
+
+config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
 	select COMPAT_BINFMT_ELF
-- 
2.5.0
