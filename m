From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:02:21 +0100
Subject: [PATCH 0/3] ARM: enable cache via Trusted Foundations firmware
Message-ID: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set enables platforms using Trusted Foundations firmware to use
their L2 cache. L2 cache can be enabled only by calling the firmware.

Micha? Miros?aw (3):
  ARM: cache-l2x0: share l2x0_base with PMU code
  ARM: trusted_foundations: enable L2x0 cache via firmware_ops
  ARM: trusted_foundations: announce firmware version

 arch/arm/firmware/trusted_foundations.c    | 67 +++++++++++++++++++++-
 arch/arm/include/asm/hardware/cache-l2x0.h |  6 +-
 arch/arm/mm/cache-l2x0-pmu.c               |  9 +--
 arch/arm/mm/cache-l2x0.c                   | 14 ++++-
 4 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.19.1
