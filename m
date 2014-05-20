From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 17:35:05 +0200
Subject: [PATCH RFCv2 5/5] ARM: mvebu: add debugging message indicating the
 status of I/O coherency
In-Reply-To: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400600105-3013-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the requirements for I/O coherency to work may not be trivial,
it's useful to have a debugging message that indicates whether the
hardware I/O coherency is enabled or not.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 2a204d0..6fad623 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -363,6 +363,11 @@ int __init coherency_init(void)
 		 type == COHERENCY_FABRIC_TYPE_ARMADA_380)
 		armada_375_380_coherency_init(np);
 
+	if (type != COHERENCY_FABRIC_TYPE_NONE)
+		pr_info("hardware I/O coherency enabled\n");
+	else
+		pr_info("hardware I/O coherency disabled\n");
+
 	return 0;
 }
 
-- 
1.9.3
