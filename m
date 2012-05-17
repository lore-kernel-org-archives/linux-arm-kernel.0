From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 17 May 2012 12:40:37 -0400
Subject: [PATCH 1/5] arm: remove ability to select CONFIG_MCA
In-Reply-To: <1337272841-25931-1-git-send-email-paul.gortmaker@windriver.com>
References: <1337272841-25931-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1337272841-25931-2-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It isn't clear to me why this ever existed, as I've never heard
of an ARM board with an MCA bus.  Regardless, the MCA bus support
is going away, so remove the ability to select it from ARM.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/Kconfig |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36586dba..695cc39 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -101,14 +101,6 @@ config EISA
 config SBUS
 	bool
 
-config MCA
-	bool
-	help
-	  MicroChannel Architecture is found in some IBM PS/2 machines and
-	  laptops.  It is a bus system similar to PCI or ISA. See
-	  <file:Documentation/mca.txt> (and especially the web page given
-	  there) before attempting to build an MCA bus kernel.
-
 config STACKTRACE_SUPPORT
 	bool
 	default y
-- 
1.7.9.1
