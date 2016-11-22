From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 11:41:48 +0100
Subject: [PATCH 0/3] ARM: da8xx: fix section mismatch in new drivers
Message-ID: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar noticed there's a section mismatch in the da8xx-mstpri and
da8xx-ddrctl drivers. This is caused by calling
of_flat_dt_get_machine_name() which has an __init annotation.

This series addresses this issue by introducing a new function that
allows to retrieve the compatible property of the root node and
using it instead of of_flat_dt_get_machine_name() in the new drivers.

Bartosz Golaszewski (3):
  of: base: add support to get machine compatible string
  bus: da8xx-mstpri: drop the call to of_flat_dt_get_machine_name()
  memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name()

 drivers/bus/da8xx-mstpri.c    |  2 +-
 drivers/memory/da8xx-ddrctl.c |  2 +-
 drivers/of/base.c             | 22 ++++++++++++++++++++++
 include/linux/of.h            |  6 ++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.9.3
