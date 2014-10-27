From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Oct 2014 16:32:35 +0100
Subject: [PATCHv2 3/3] ARM: mvebu: add missing of_node_put() call in
 coherency.c
In-Reply-To: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414423955-5933-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a missing of_node_put() to decrement the device_node
reference counter after a of_find_matching_node() in coherency_init().

Fixes: 501f928e0097 ("ARM: mvebu: add a coherency_available() call")
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index abf4535..ee44965 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -409,6 +409,8 @@ int __init coherency_init(void)
 		 type == COHERENCY_FABRIC_TYPE_ARMADA_380)
 		armada_375_380_coherency_init(np);
 
+	of_node_put(np);
+
 	return 0;
 }
 
-- 
2.0.0
