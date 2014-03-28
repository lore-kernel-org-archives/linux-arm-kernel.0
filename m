From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 28 Mar 2014 14:50:27 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20140328145027.fef73dc688be565c6a6e9210@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in
arch/arm/mach-zynq/common.c between commit 016f4dcae81e ("ARM: zynq:
Split slcr in two parts") from the arm-soc tree and commit cd325295871f
("arm: zynq: Add support for cpufreq") from the tip tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-zynq/common.c
index dca60d5ba756,a39be8e80856..000000000000
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@@ -73,8 -74,7 +75,9 @@@ static void __init zynq_init_machine(vo
  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
  
  	platform_device_register(&zynq_cpuidle_device);
+ 	platform_device_register_full(&devinfo);
 +
 +	zynq_slcr_init();
  }
  
  static void __init zynq_timer_init(void)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/15e4d4b6/attachment-0001.sig>
