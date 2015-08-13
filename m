From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Thu, 13 Aug 2015 14:33:37 -0700
Subject: [PATCH 0/3] qcom: Add SMEM MTD parser
Message-ID: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QCOM platforms such as IPQ806x are using SMEM to store their flash
layout. This patch set adds the DT nodes required to instanciate SMEM
on IPQ806x and add an MTD parser using it.

This change is based on the SMEM driver posted here:
*https://lkml.org/lkml/2015/7/27/1125

Mathieu Olivari (3):
  ARM: qcom: add SFPB nodes to IPQ806x dts
  ARM: qcom: add SMEM device node to IPQ806x dts
  mtd: add SMEM parser for QCOM platforms

 arch/arm/boot/dts/qcom-ipq8064.dtsi |  23 +++-
 drivers/mtd/Kconfig                 |   7 ++
 drivers/mtd/Makefile                |   1 +
 drivers/mtd/qcom_smem_part.c        | 224 ++++++++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/qcom_smem_part.c

-- 
2.1.4
