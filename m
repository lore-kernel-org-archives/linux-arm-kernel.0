From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 18 Mar 2015 16:31:18 +0530
Subject: [PATCH] arm64: defconfig: increase NR_CPUS range to 2-4096.
Message-ID: <1426676478-12870-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>

Raising the maximum limit to 4096.
This is to accomadate up-coming higher multi-core platforms.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..d236960 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -455,8 +455,8 @@ config SCHED_SMT
 	  places. If unsure say N here.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-64)"
-	range 2 64
+	int "Maximum number of CPUs (2-4096)"
+	range 2 4096
 	depends on SMP
 	# These have to remain sorted largest to smallest
 	default "64"
-- 
1.8.1.4
