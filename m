From: joelf@ti.com (Joel Fernandes)
Date: Wed, 26 Jun 2013 22:41:45 -0500
Subject: [PATCH v2 0/2] DMA: EDMA: Config and comments
Message-ID: <1372304505-30707-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor patches remaining after EDMA series was posted.

First patch adds the TI_EDMA option which people can forget to add and
can result in failure without any informative errors of why DMA is not
working. There was a discussion on avoiding Kconfig and putting this in
the defconfig instead.

Second patch adds comments to the EDMA code for the calculations in the
A-sync case. From my experience, this code is not-so-obvious. Hopefully
this makes the life of readers of the code a little better.

Joel Fernandes (2):
  ARM: configs: Enable TI_EDMA in omap2plus_defconfig
  DMA: EDMA: Add comments for A-sync case calculations

 arch/arm/configs/omap2plus_defconfig |    1 +
 drivers/dma/edma.c                   |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
1.7.9.5
