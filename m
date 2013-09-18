From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 18 Sep 2013 09:23:19 -0700
Subject: Tegra baseline test results for v3.12-rc1
Message-ID: <A4DCC42E2B5835498682FCB0A8F9F873378C267FFD@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.12-rc1.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc1/20130916143118/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
    Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267)):
   text     data      bss    total  kernel
 -89208   +10000     -416   -79624  multi_v7_defconfig
+299303    +7244    +1484  +308031  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267))
    avail    rsrvd     high    freed                board              kconfig                  dtb
        .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
    -324k     324k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
    -324k     324k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    -592k     592k        .       8k       tegra30-beaver      tegra_defconfig       tegra30-beaver
