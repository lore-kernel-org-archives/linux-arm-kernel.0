From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 13:57:46 +0100
Subject: [PATCH v2 0/2] da8xx: fix section mismatch in new drivers
Message-ID: <1479819468-4016-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar noticed there's a section mismatch in the da8xx-mstpri and
da8xx-ddrctl drivers. This is caused by calling
of_flat_dt_get_machine_name() which has an __init annotation.

This series addresses this issue by open coding routines that return
the machine compatible string in both drivers. Once a general function
for that in of/base is merged, we'll remove them.

v1 -> v2:
- drop patch [1/3] from v1
- introduce internal routines in the drivers instead of a general
  function in of/base.c

Bartosz Golaszewski (2):
  bus: da8xx-mstpri: drop the call to of_flat_dt_get_machine_name()
  memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name()

 drivers/bus/da8xx-mstpri.c    | 22 ++++++++++++++++++++--
 drivers/memory/da8xx-ddrctl.c | 22 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.9.3
