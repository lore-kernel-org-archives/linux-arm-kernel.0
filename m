From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 20 Jul 2017 12:03:58 +0100
Subject: [PATCH 0/4] Drop uninformative messages from bootlog
Message-ID: <20170720110402.15313-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While booting v4.13-rc1 on an arm64 system, I noticed some messages
that clutter the boot log without providing any useful
information. This series trims some of the obvious offenders.

The patches are spread across a few sub-systems - arm64/mm, mailbox,
APEI and xen, and can be independently merged.

Thanks,
Punit


Punit Agrawal (4):
  arm64/numa: Drop duplicate message
  mailbox: pcc: Drop uninformative output during boot
  ACPI / APEI: Drop uninformative messages during boot
  xen: Drop un-informative message during boot

 arch/arm64/mm/numa.c      | 7 +------
 drivers/acpi/apei/ghes.c  | 9 +--------
 drivers/mailbox/pcc.c     | 4 +---
 drivers/xen/xenfs/super.c | 1 -
 4 files changed, 3 insertions(+), 18 deletions(-)

-- 
2.11.0
