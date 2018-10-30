From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Oct 2018 16:14:58 +0100
Subject: [PATCH 0/2] constify thermal_zone_of_device_ops structures
Message-ID: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal_zone_of_device_ops structures can be const as they are
only passed as the last argument of a thermal_zone_of_sensor_register
function and the corresponding parameter is declared as const.

Done with the help of Coccinelle.

---

 drivers/thermal/armada_thermal.c           |    2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
