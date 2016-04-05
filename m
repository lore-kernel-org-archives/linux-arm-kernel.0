From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 6 Apr 2016 01:08:24 +0300
Subject: [PATCH 02/25] all: introduce COMPAT_WRAPPER option and enable it for
 s390
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1459894127-17698-3-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/Kconfig      | 4 ++++
 arch/s390/Kconfig | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 81869a5..92fcbd4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -589,6 +589,10 @@ config HAVE_STACK_VALIDATION
 	  Architecture supports the 'objtool check' host tool command, which
 	  performs compile-time stack metadata validation.
 
+config COMPAT_WRAPPER
+	bool
+	depends on COMPAT
+
 #
 # ABI hall of shame
 #
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index aad23e3..cdc02e0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -337,6 +337,7 @@ config COMPAT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	select COMPAT_WRAPPER
 	depends on MULTIUSER
 	help
 	  Select this option if you want to enable your system kernel to
-- 
2.5.0
