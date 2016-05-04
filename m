From: ray.jui@broadcom.com (Ray Jui)
Date: Wed,  4 May 2016 16:47:14 -0700
Subject: [PATCH v2] Workaround for Broadcom NS2 gicv2m implementation
Message-ID: <1462405635-27864-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
implementation has an erratum where the MSI data needs to be the SPI number
subtracted by an offset of 32, for the correct MSI interrupt to be triggered.

We are now implementating the workaround based on readings from the MSI_IIDR
register.

Patch series is developed based on Linux v4.6-rc1 and available at:
https://github.com/Broadcom/arm64-linux/tree/gicv2m-iproc-v2

Changes from v1:
 - Changed from DT based approach to the approch similar to APM that is based
on readings from the MSI_IIDR register

Ray Jui (1):
  irqchip/gic-v2m: Add workaround for Broadcom NS2 GICv2m erratum

 drivers/irqchip/irq-gic-v2m.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.1.4
