From: sjur.brandeland@stericsson.com (Sjur Braendeland)
Date: Fri, 22 Oct 2010 21:03:51 +0200
Subject: [PATCH 0/4] caif-u5500: CAIF shared memory/mailbox driver
Message-ID: <1287774235-11151-1-git-send-email-sjur.brandeland@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch-set introduces the CAIF protocol driver for shared memory
over mailbox for u5500.

It implements the driver for transporting CAIF frames between the DB5500
modem portion and host side for the u5500 architecture.

These patches depends on the patch-set "U5500 mailbox driver and
modem irq handler" submitted on the linux-arm-kernel list,
commit e81fcc97350755e021c85b816877ae292b8f28d0.

They applies cleanly on latest net-next-2.6 and linux-next git,
and depends on the CONFIG_U5500_MBX for compilation.

Please note that the size and address of the shared memory are specified as
module parameters: shm_total_size, shm_start.

Regards,
Sjur Braendeland

Amarnath Revanna (4):
  caif-u5500: Adding shared memory include
  caif-u5500: CAIF shared memory transport protocol
  caif-u5500: CAIF shared memory mailbox interface
  caif-u5500: Build config for CAIF shared mem driver

 drivers/net/caif/Kconfig          |    7 +
 drivers/net/caif/Makefile         |    4 +
 drivers/net/caif/caif_shm_u5500.c |  129 ++++++
 drivers/net/caif/caif_shmcore.c   |  792 +++++++++++++++++++++++++++++++++++++
 include/net/caif/caif_shm.h       |   26 ++
 5 files changed, 958 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/caif/caif_shm_u5500.c
 create mode 100644 drivers/net/caif/caif_shmcore.c
 create mode 100644 include/net/caif/caif_shm.h
