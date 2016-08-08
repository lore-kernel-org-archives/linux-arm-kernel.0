From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Mon, 8 Aug 2016 18:44:20 +0300
Subject: [PATCH v2 0/2] Display regmap values in debugfs for write only
 registers
In-Reply-To: <20160804154814.GA10383@sirena.org.uk>
References: <20160804154814.GA10383@sirena.org.uk>
Message-ID: <1470671062-25479-1-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thank you for the review and for the very detailed comments. I updated the 
patch series to fix the problems identified. To make sure a register is 
really cached a regcache_read() is performed on cacheable registers.

The patch was tested using a wm8731 device.

Changes since v1 (https://lkml.org/lkml/2016/8/4/327)
	+ Fix regmap_cached() to return if a register is really cached
	  instead of cacheable. 
	+ Remove unnecesary regcache_read() in regmap_read_debugfs()  

Cristian Birsan (2):
  regmap: Add a function to check if a regmap register is cached
  regmap: debugfs: Add support for dumping write only device registers

 drivers/base/regmap/internal.h       |  1 +
 drivers/base/regmap/regmap-debugfs.c | 16 +++++++++++++---
 drivers/base/regmap/regmap.c         | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
1.9.1
