From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  9 Sep 2018 21:10:11 +0200
Subject: [PATCH v2 0/4] Follow-up patches for Cedrus v9
Message-ID: <20180909191015.20902-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This brings the requested modifications on top of version 9 of the
Cedrus VPU driver, that implements stateless video decoding using the
Request API.

Changes since v1:
* Added two more commits to fix build issues with non-sunxi configs.

In order to build correctly on non-sunxi platforms, the following commit
is also required to select the sunxi SRAM driver:
* drivers: soc: Allow building the sunxi driver without ARCH_SUNXI

Paul Kocialkowski (4):
  media: cedrus: Fix error reporting in request validation
  media: cedrus: Add TODO file with tasks to complete before unstaging
  media: cedrus: Wrap PHYS_PFN_OFFSET with ifdef and add dedicated
    comment
  media: cedrus: Select the sunxi SRAM driver in Kconfig

 drivers/staging/media/sunxi/cedrus/Kconfig     |  1 +
 drivers/staging/media/sunxi/cedrus/TODO        |  7 +++++++
 drivers/staging/media/sunxi/cedrus/cedrus.c    | 15 ++++++++++++---
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c |  5 +++++
 4 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/TODO

-- 
2.18.0
