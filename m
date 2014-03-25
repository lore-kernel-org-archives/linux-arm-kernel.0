From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:17 +0000
Subject: [RFC 00/47] mtd: nand: Add new driver supporting ST's BCH h/w
Message-ID: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This patch-set was written against kernel version v3.4, but applies
cleanly to v3.13-rc7 which it is currently based. I understand that
the core has changed significantly since and that some of the
infrastructure this driver provides is now available either through
the framework or similar means. I'm looking for someone with inside
knowledge to draw attention to those areas so we can align with the
most recent API.

Any help would be gratefully received.

 drivers/mtd/nand/Kconfig         |   13 +
 drivers/mtd/nand/Makefile        |    2 +
 drivers/mtd/nand/nand_base.c     |   18 +-
 drivers/mtd/nand/nand_ids.c      |  165 ++++++++
 drivers/mtd/nand/stm_nand_bch.c  | 2769 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/stm_nand_dt.c   |  146 +++++++
 drivers/mtd/nand/stm_nand_dt.h   |   39 ++
 drivers/mtd/nand/stm_nand_regs.h |  302 ++++++++++++++
 include/linux/mtd/nand.h         |   40 ++
 include/linux/mtd/stm_nand.h     |  104 +++++
 10 files changed, 3591 insertions(+), 7 deletions(-)
