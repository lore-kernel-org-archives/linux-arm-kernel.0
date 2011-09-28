From: msalter@redhat.com (Mark Salter)
Date: Wed, 28 Sep 2011 11:35:16 -0400
Subject: nr_cpus cmdline parameter not working
Message-ID: <1317224117.2580.84.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I noticed that nr_cpus=1 doesn't appear to have any effect on a
pandaboard (and probably others from the looks of things). This
changes seems to be needed, but I'm not really sure if this is
the right thing or not.

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index ce65e93..a1198ac 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -117,6 +117,9 @@ void __init smp_init_cpus(void)
 		ncores = NR_CPUS;
 	}
 
+	if (ncores > nr_cpu_ids)
+		ncores = nr_cpu_ids;
+
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);

--Mark
