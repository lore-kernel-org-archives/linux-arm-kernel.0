From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Jan 2011 14:21:20 +0530
Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1295859080-15259-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 	if (!skip_secondary_calibrate) {
 		for_each_online_cpu(cpu)
-			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
+			bogosums += per_cpu(cpu_data, cpu).loops_per_jiffy;
 
-		snprintf(bogosum, sizeof(bogosum), " (%lu.%02lu BogoMIPS).\n",
-			bogosum / (500000/HZ), (bogosum / (5000/HZ)) % 100);
+		snprintf(bogosum, sizeof(bogosums), " (%lu.%02lu BogoMIPS).\n",
+			bogosums / (500000/HZ), (bogosums / (5000/HZ)) % 100);
 	} else
 		bogosum[0] = '\0';
 
