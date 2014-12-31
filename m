From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 31 Dec 2014 13:06:16 +0530
Subject: [RFC PATCH v3 1/4] arm64: defconfig: increase NR_CPUS range to 2-4096.
In-Reply-To: <1420011379-7116-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1420011379-7116-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <1420011379-7116-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Raising the maximum limit to 4096.
This is to accomadate up-coming higher multi-core platforms.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 61fbd1f..242419d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -302,8 +302,8 @@ config SCHED_SMT
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
