From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 12:06:30 +0530
Subject: [PATCH 0/3] mfd: Handle platform_get_irq's error checking and return
Message-ID: <1510986993-4936-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct and we must check its return value.

Arvind Yadav (3):
  [PATCH 1/3] mfd: ipaq-micro: Fix platform_get_irq's error checking
  [PATCH 2/3] mfd: intel-lpss: Handle return value of platform_get_*
  [PATCH 3/3] mfd: sun4i-gpadc: Handle return value of platform_get_irq

 drivers/mfd/intel-lpss-acpi.c | 2 ++
 drivers/mfd/ipaq-micro.c      | 4 ++--
 drivers/mfd/sun4i-gpadc.c     | 7 +++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.7.4
