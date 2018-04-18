From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 18 Apr 2018 17:35:50 +0200
Subject: [PATCH 0/2] memory: aemif: add support for machine code
Message-ID: <20180418153552.14632-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the series that contained both changes to the
aemif driver and platform code. It contains only the driver changes.

As the first step in removing duplicate support for aemif from the
kernel we need to add support for board files to the aemif memory
driver.

First patch just uses a static string for the ti-aemif driver name.

The second adds support for board files to the aemif driver.

This series includes changes requested by Sekhar in his code review:
- made aemif the parent of each sub-device before registering it
- documented the new members in aemif_platform_data

Bartosz Golaszewski (2):
  memory: aemif: don't rely on kbuild for driver's name
  memory: aemif: add support for board files

 drivers/memory/ti-aemif.c              | 60 +++++++++++++++++---------
 include/linux/platform_data/ti-aemif.h | 25 +++++++++++
 2 files changed, 64 insertions(+), 21 deletions(-)

-- 
2.17.0
