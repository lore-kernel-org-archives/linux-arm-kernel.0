From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 27 Mar 2017 14:18:22 +0100
Subject: [PATCH v3 6/9] drivers: remove useless comment from
 base/arch_topology.c
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Message-ID: <20170327131825.32134-7-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing out an error message when we failed to get the cpu device is
not helping anyone. Remove it.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/base/arch_topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c33482121b7d..b24d9a2af2c5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -81,11 +81,9 @@ static int register_cpu_capacity_sysctl(void)
 
 	for_each_possible_cpu(i) {
 		cpu = get_cpu_device(i);
-		if (!cpu) {
-			pr_err("%s: too early to get CPU%d device!\n",
-			       __func__, i);
+		if (!cpu)
 			continue;
-		}
+
 		device_create_file(cpu, &dev_attr_cpu_capacity);
 	}
 
-- 
2.10.0
