From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 May 2016 11:38:09 +0200
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors variants
Message-ID: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the current SCPI implementation, based on [0]:
- is (at leat) JUNO specific
- does not specify a strong "standard"
- does not specify a strong MHU interface specification

SoC vendors could implement a variant with slight changes in message
indexes, new messages types, different messages data format or different MHU
communication scheme.

To keep the spirit of the SCPI interface, add a thin "register" layer to get
the ops from the parent node and switch the drivers using the ops to use
the new of_scpi_ops_get() call.

[0] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html

Neil Armstrong (2):
  firmware: Add a SCPI framework to handle multiple vendors
    implementation
  firmware: scpi: Switch scpi drivers to use new Framework calls

 drivers/clk/clk-scpi.c         |  18 ++++---
 drivers/cpufreq/scpi-cpufreq.c |   7 +--
 drivers/firmware/Makefile      |   1 +
 drivers/firmware/arm_scpi.c    |  18 +++----
 drivers/firmware/scpi.c        | 110 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/scpi-hwmon.c     |   6 +--
 include/linux/scpi_protocol.h  |  33 ++++++++++++-
 7 files changed, 169 insertions(+), 24 deletions(-)
 create mode 100644 drivers/firmware/scpi.c

-- 
2.7.0
