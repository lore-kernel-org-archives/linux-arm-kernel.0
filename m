From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Thu, 4 Aug 2016 17:55:56 +0300
Subject: [PATCH 0/2] Display regmap values in debugfs for write only registers
Message-ID: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for dumping write only device registers in
regmap debugfs.This is useful for debuging devices like audio codecs (such 
as WM8731) and maybe other devices. It addresses the problem described in
the following thread: https://lkml.org/lkml/2015/6/13/98

The logic that decides if the values can be printed is moved to
regmap_printable() function to allow for easier future updates.

Please let me know if you have other sugestions.

Kind regards,
Cristian

Cristian Birsan (2):
  regmap: Add a function to check if a regmap register is cached
  regmap: debugfs: Add support for dumping write only device registers

 drivers/base/regmap/internal.h       |  1 +
 drivers/base/regmap/regmap-debugfs.c | 22 ++++++++++++++++++----
 drivers/base/regmap/regmap.c         | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
1.9.1
