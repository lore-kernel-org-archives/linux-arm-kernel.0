From: avinashphilip@ti.com (Philip Avinash)
Date: Fri, 18 Jan 2013 12:11:32 +0530
Subject: [PATCH 0/3] Add device tree support for NAND flash in am335x-evm
Message-ID: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds device tree support for NAND flash in am335x-evm.
Also ELM node is populated in device tree and been used for BCH error
correction in NAND flash part. Also this patch series ensures RBL ecc
layout maintained in Linux kernel with BCH8 ecc scheme.

This patch series based on [1] and depends on [2] & [3].

1. http://git.kernel.org/?p=linux/kernel/git/bcousson/linux-omap-dt.git;a=tree;h=refs/heads/for_3.9/dts;hb=refs/heads/for_3.9/dts
2. OMAP GPMC DT bindings
   http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=shortlog;h=refs/heads/omap-for-v3.9/gpmc
3. mtd: nand: OMAP: ELM error correction support for BCH ecc
   http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/shortlog/refs/heads/master


Philip Avinash (1):
  ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm

Philip, Avinash (2):
  ARM: dts: AM33XX: Add ELM node
  ARM: dts: AM33XX: Add GPMC node

 arch/arm/boot/dts/am335x-evm.dts |   93 +++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi    |   18 ++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)

-- 
1.7.9.5
