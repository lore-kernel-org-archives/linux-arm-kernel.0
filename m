From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Wed, 5 Jul 2017 18:25:02 +0800
Subject: [PATCH 0/2] add support for Spreadtrum's FM driver
In-Reply-To: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
References: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170705102502.2295-1-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[add linux-media list and Mauro Carvalho Chehab]

According to GregKH's suggestion [1], we tried to simply sort out the
FM driver source code which has been using in the internal projects.

Hopes it can help for fixing the problem raised in [1].

[1] https://lkml.org/lkml/2017/6/28/222

Chunyan Zhang (2):
  arm64: dts: add Spreadtrum's fm support
  misc: added Spreadtrum's radio driver

 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts      |    4 +
 drivers/misc/Kconfig                           |    1 +
 drivers/misc/Makefile                          |    1 +
 drivers/misc/sprd-wcn/Kconfig                  |   14 +
 drivers/misc/sprd-wcn/Makefile                 |    1 +
 drivers/misc/sprd-wcn/radio/Kconfig            |    8 +
 drivers/misc/sprd-wcn/radio/Makefile           |    2 +
 drivers/misc/sprd-wcn/radio/fmdrv.h            |  595 +++++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_main.c       | 1245 ++++++++++++++++++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_main.h       |  117 +++
 drivers/misc/sprd-wcn/radio/fmdrv_ops.c        |  447 +++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_ops.h        |   17 +
 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c |  753 ++++++++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h |  103 ++
 14 files changed, 3308 insertions(+)
 create mode 100644 drivers/misc/sprd-wcn/Kconfig
 create mode 100644 drivers/misc/sprd-wcn/Makefile
 create mode 100644 drivers/misc/sprd-wcn/radio/Kconfig
 create mode 100644 drivers/misc/sprd-wcn/radio/Makefile
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv.h
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_main.c
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_main.h
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_ops.c
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_ops.h
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h

-- 
2.7.4
