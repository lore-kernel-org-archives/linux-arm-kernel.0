From: mark.brown314@gmail.com (Mark F. Brown)
Date: Thu, 26 Aug 2010 04:56:50 -0400
Subject: [PATCH] ARM: pxa3xx: fix build error when CONFIG_MTD_PARTITIONS is
	not defined
Message-ID: <1282813011-6187-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_MTD_PARTITIONS is not defined for pxa3xx NAND driver it will display a build error:

drivers/built-in.o: In function `pxa3xx_nand_remove':
drivers/mtd/nand/pxa3xx_nand.c:1367: undefined reference to `del_mtd_partitions'
drivers/built-in.o: In function `pxa3xx_nand_probe':
drivers/mtd/nand/pxa3xx_nand.c:1334: undefined reference to `add_mtd_partitions'
make: *** [.tmp_vmlinux1] Error 1

Patched against Eric Miao's pxa tree

Mark F. Brown (1):
  ARM: pxa3xx: fix build error when CONFIG_MTD_PARTITIONS is not
    defined

 drivers/mtd/nand/pxa3xx_nand.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
