From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Sat, 22 Nov 2014 02:53:27 +0530
Subject: [RFC PATCH v2 1/4] arm64: defconfig: increase NR_CPUS range to 2-128
In-Reply-To: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <1416605010-10442-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Raising the maximum limit to 128. This is needed for Cavium's
Thunder system that will have 96 cores on Multi-node system.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c1ad0df..f272926 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -302,8 +302,8 @@ config SCHED_SMT
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
