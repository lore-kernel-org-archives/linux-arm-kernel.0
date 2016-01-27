From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jan 2016 16:57:16 +0100
Subject: [PATCH 0/7] SCSI bug fixes for 4.6
Message-ID: <1453910247-3447628-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a bunch of fixes for harmless bugs I found during ARM
randconfig testing. It would be nice to get them mered in 4.6,
but there is no need to have them in 4.5 as no incorrect behavior
results from the current code, and the warnings are all hard
to trigger.

Arnd Bergmann (7):
  scsi: fdomain: drop fdomain_pci_tbl when built-in
  mptfusion: hide unused seq_mpt_print_ioc_summary function
  scsi: acornscsi: mark calc_sync_xfer as __maybe_unused
  scsi: fas216: avoid fas216_log_setup for loadable module
  scsi: qla4xxx: shut up warning for rd_reg_indirect
  scsi: aha1542: avoid uninitialized variable warnings
  scsi_dh: force modular build if SCSI is a module

 drivers/message/fusion/mptbase.c    | 2 ++
 drivers/scsi/aha1542.c              | 3 +++
 drivers/scsi/arm/acornscsi.c        | 3 ++-
 drivers/scsi/arm/fas216.c           | 2 ++
 drivers/scsi/device_handler/Kconfig | 8 ++++----
 drivers/scsi/fdomain.c              | 2 +-
 drivers/scsi/qla4xxx/ql4_83xx.c     | 6 ++++--
 7 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.7.0
