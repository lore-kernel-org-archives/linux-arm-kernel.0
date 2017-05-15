From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 15 May 2017 20:14:43 +0900
Subject: [PATCH 0/5] devicetree: cleanup and improve DT cross-arch reference
Message-ID: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series depends on Olof's
"devicetree: Move include prefixes from arch to separate directory"
https://patchwork.kernel.org/patch/9724995/

1/5: clean-up of unused include path
2/5: Fixup of last three DT files in ARM (needed for 4/5)
3/5: Fixup of last three DT files in PowerPC (needed for 4/5)
4/5: Remove arch/$(SRCARCH)/boot/dts include path
5/5: Make DT cross-arch reference available for /include/ directive


Masahiro Yamada (5):
  of: remove drivers/of/testcase-data from include search path for CPP
  ARM: dts: use #include "..." to include DT in the same directory
  powerpc: dts: use #include "..." to include DT in the same directory
  of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
  of: add scripts/dtc/include-prefixes to search path for both CPP and
    DTC

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 arch/arm/boot/dts/versatile-pb.dts    | 2 +-
 arch/powerpc/boot/dts/ac14xx.dts      | 2 +-
 arch/powerpc/boot/dts/mpc5121ads.dts  | 2 +-
 arch/powerpc/boot/dts/pdm360ng.dts    | 2 +-
 scripts/Makefile.lib                  | 8 ++++----
 7 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4
