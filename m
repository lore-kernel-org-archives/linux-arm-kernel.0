From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Thu, 25 Sep 2014 14:33:56 +0530
Subject: [RFC PATCH 1/4] arm64: defconfig: increase NR_CPUS range to 2-128
In-Reply-To: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1411635840-24038-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <1411635840-24038-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Raising the maximum limit to 128. This is needed for Cavium's
Thunder systems that will have 96 cores on Multi-node system.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4d42453..a409105 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -296,8 +296,8 @@ config SCHED_SMT
 	  places. If unsure say N here.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-64)"
-	range 2 64
+	int "Maximum number of CPUs (2-128)"
+	range 2 128
 	depends on SMP
 	# These have to remain sorted largest to smallest
 	default "64"
-- 
1.8.1.4
