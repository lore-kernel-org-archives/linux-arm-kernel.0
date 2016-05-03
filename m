From: ray.jui@broadcom.com (Ray Jui)
Date: Tue,  3 May 2016 16:47:23 -0700
Subject: [PATCH 0/2] Add DT based gicv2m spi offset support
Message-ID: <1462319245-32532-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
implementation has an erratum where the MSI data needs to be the SPI number
subtracted by an offset of 32, for the correct MSI interrupt to be triggered.
    
We are aware that APM X-Gene GICv2m has a similar erratum where the MSI data
needs to be the offset from the spi_start. While APM's workaround is triggered
based on readings from the MSI_IIDR register, this patch series contains a more
general solution by allowing this offset to be specified with an optional DT
property 'arm,msi-offset-spi'. This patch series also maintains compatibility
with existing APM platforms

Kindly let us know if it's preferred for Broadcom's workaround to be also based
on the readings from the MSI_IIDR register.

Patch series is developed based on Linux v4.6-rc1 and available at:
https://github.com/Broadcom/arm64-linux/tree/gicv2m-iproc-v1

Ray Jui (2):
  dt-bindings: arm,gic: Indtroduce optional property
    'arm,msi-offset-spi'     for gicv2m
  irqchip/gic-v2m: Add workaround for Broadcom NS2 GICv2m erratum

 .../bindings/interrupt-controller/arm,gic.txt      |  6 ++++
 drivers/irqchip/irq-gic-v2m.c                      | 35 ++++++++++++++++++----
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.1.4
