From: ray.jui@broadcom.com (Ray Jui)
Date: Thu,  5 May 2016 09:32:00 -0700
Subject: [PATCH v3] Workaround for Broadcom NS2 gicv2m implementation
Message-ID: <1462465921-3220-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
implementation has an erratum where the MSI data needs to be the SPI number
subtracted by an offset of 32, for the correct MSI interrupt to be triggered.

We are now implementating the workaround based on readings from the MSI_IIDR
register.

Patch series is developed based on Linux v4.6-rc1 and available at:
https://github.com/Broadcom/arm64-linux/tree/gicv2m-iproc-v3

Changes from v2:
 - Improved the logic of dealing with MSI_IIDR readings by using a switch
statement suggested by Marc Zyngier

Changes from v1:
 - Changed from DT based approach to the approch similar to APM that is based
on readings from the MSI_IIDR register

Ray Jui (1):
  irqchip/gic-v2m: Add workaround for Broadcom NS2 GICv2m erratum

 drivers/irqchip/irq-gic-v2m.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.1.4
