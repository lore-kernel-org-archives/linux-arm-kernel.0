From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 9 Jun 2017 15:43:25 +0300
Subject: arm64: build is broken on next-20170609 with merge-commit
 9afca2c4e379 (arm64: allwinner: sun50i-a64: add dwmac-sun8i Ethernet driver)
Message-ID: <20170609124325.p7b6fhdbwtki4w2z@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Today's linux-next breaks build with:
  DTC     arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dtb
arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dtb: ERROR (duplicate_node_names): Duplicate node name /soc/ethernet at 1c30000
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:325: recipe for target 'arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dtb' failed
make[2]: *** [arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dtb] Error 2
scripts/Makefile.build:561: recipe for target 'arch/arm64/boot/dts/allwinner' failed
make[1]: *** [arch/arm64/boot/dts/allwinner] Error 2 arch/arm64/Makefile:130: recipe for target 'dtbs' failed
make: *** [dtbs] Error 2

It seems, it's due to duplication error in merge-commit 9afca2c4e379.
Removing it fixes the build.

Yury
