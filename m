From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 23 Nov 2016 14:39:58 +0100
Subject: [PATCH v4 0/2] da8xx: fix section mismatch in new drivers
Message-ID: <1479908400-10136-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar noticed there's a section mismatch in the da8xx-mstpri and
da8xx-ddrctl drivers. This is caused by calling
of_flat_dt_get_machine_name() which has an __init annotation.

This series makes the drivers drop the call and not print the
machine name in the error message.

v1 -> v2:
- drop patch [1/3] from v1
- introduce internal routines in the drivers instead of a general
  function in of/base.c

v2 -> v3:
- use of_property_read_string_index() instead of
  of_property_read_string() to get the first compatible entry
- s/priotities/priorities

v3 -> v4:
- drop the compatible string printing altogether as the new function
  is not safe
- merge the typo fix into patch [1/2]

Bartosz Golaszewski (2):
  bus: da8xx-mstpri: drop the call to of_flat_dt_get_machine_name()
  memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name()

 drivers/bus/da8xx-mstpri.c    | 4 +---
 drivers/memory/da8xx-ddrctl.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.9.3
