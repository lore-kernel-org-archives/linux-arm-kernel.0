From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 15 Feb 2016 07:46:37 +0000 (UTC)
Subject: OMAP baseline test results for v4.5-rc4
Message-ID: <alpine.DEB.2.02.1602150744500.26085@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic OMAP test results for Linux v4.5-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.5-rc4/20160214144827/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-stk-om44,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig_n800_only_a/omap2420-n800,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    Pass (18/18): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  omap2plus_defconfig_ti81xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Build warnings from toolchain: uImage:
    (none)

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL ( 1/18): multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/18): 2430sdp
    skip ( 3/18): 5912osk, 3517evm, 5430es2sbct54
    Pass (14/18): am335xbonelt, am437xsk, am335xbone, 4430es2panda,
		  4460pandaes, 4460varsomom, 37xxevm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm,
		  cmt3517, 5430es2uevm, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 1/18): cmt3517

PM: chip retention via suspend:
    FAIL ( 7/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 2430sdp, 5430es2uevm
    Pass ( 4/11): 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 9/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  2430sdp, 5430es2uevm
    Pass ( 2/11): 3730beaglexm, 3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 37xxevm, 3530es3beagle
    Pass ( 2/ 4): 3530es31beagle, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 37xxevm, 3530es3beagle, 3530es31beagle
    Pass ( 1/ 4): 3730es12beaglexm

Kernel warnings during PM test:
    (none)

Obsolete Kconfig symbols:
    FAIL ( 3/21): omap1_defconfig, omap2plus_defconfig,
		  multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.5-rc3 (388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95)):
   text     data      bss    total  kernel
  +1164      +64      +32    +1260  omap1_defconfig
  +1196      +64      +32    +1292  omap1_defconfig_1510innovator_only
  +1132      +32      +32    +1196  omap1_defconfig_5912osk_only
  +5346     +160        0    +5506  multi_v7_defconfig
  +1052      +64  -147392  -146276  omap2plus_defconfig
   +784      +96  -147456  -146576  omap2plus_defconfig_2430sdp_only
  +5136      +64  -147392  -142192  omap2plus_defconfig_am33xx_only
   +988      +64  -147392  -146340  omap2plus_defconfig_am43xx_only
  +1116      +64  -147392  -146212  omap2plus_defconfig_cpupm
   +988      +64  -147392  -146340  omap2plus_defconfig_dra7xx_only
   +780      +64  -147424  -146580  omap2plus_defconfig_n800_multi_omap2xxx
   +608      +32  -147456  -146816  omap2plus_defconfig_n800_only_a
  +1052      +64  -147392  -146276  omap2plus_defconfig_no_pm
  +1052      +96  -147392  -146244  omap2plus_defconfig_omap2_4_only
  +1052      +96  -147392  -146244  omap2plus_defconfig_omap3_4_only
  +1052      +96  -147392  -146244  omap2plus_defconfig_omap5_only
+8841927  +599312  +8312544  +17753783  omap2plus_defconfig_ti81xx_only
   +748      +64     -260     +552  rmk_omap3430_ldp_allnoconfig
  +1009        0  -147456  -146447  rmk_omap3430_ldp_oldconfig
   +704        0     -180     +524  rmk_omap4430_sdp_allnoconfig
  +1169       -8  -147456  -146295  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.5-rc3 (388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95))
  avail  rsrvd   high  freed  board          kconfig
   144k  -144k      .      .  2420n800       omap2plus_defconfig_n800_only_a
   144k  -144k      .      .  2430sdp        omap2plus_defconfig
   144k  -144k      .      .  3530es31beagle omap2plus_defconfig
   144k  -144k      .      .  3530es3beagle  omap2plus_defconfig
   144k  -144k      .      .  3730beaglexm   omap2plus_defconfig
   144k  -144k      .      .  3730es12beaglexmomap2plus_defconfig
   144k  -144k      .      .  37xxevm        omap2plus_defconfig
   144k  -144k      .      .  4430es2panda   omap2plus_defconfig
   144k  -144k      .      .  4460pandaes    omap2plus_defconfig
   144k  -144k      .      .  4460varsomom   omap2plus_defconfig
   144k  -144k      .      .  5430es2uevm    omap2plus_defconfig
   144k  -144k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
   144k  -144k      .      .  am335xbonelt   omap2plus_defconfig
   144k  -144k      .      .  am437xsk       omap2plus_defconfig

A buil? test for a kernel specialized for the TI81xx family of devices has 
been a??ed, along with DTB builds for the DM8148 and DM8168 EVMs.
