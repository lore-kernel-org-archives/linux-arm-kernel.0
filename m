From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 18 Jan 2011 12:21:41 -0500
Subject: [PATCH v1 0/5] davinci: da850: clean up pinmux arrays in da850.c
Message-ID: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series is an attempt to clean up unused and platform specific
pinmux arrays in the da850 CPU files.  This series was developed as a result of 
the following email thread:

http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg19921.html

This patch is against commit cda6ca38f96f0719ce3500da856e7d4bf0abbc38 of linux-davinci.

This series should not be applied until someone with a da850 EVM can please test
and confirm the mcasp and mmc interfaces continue to work properly with these patches.

---
  changes since v0:
  - correct use of __initdata/__initconst attributes

Michael Williamson (5):
  davinci: da850: remove unused pinmux array
  davinci: da850: remove unused emif pinmux array
  davinci: da850: move da850_evm specific mcasp pins to board file.
  davinci: da850: move da850_evm specific mmcsd pinmux array to board
    file.
  davinci: da850: remove unused uart pinmux arrays.

 arch/arm/mach-davinci/board-da850-evm.c    |   18 ++++++++-
 arch/arm/mach-davinci/da850.c              |   56 ----------------------------
 arch/arm/mach-davinci/include/mach/da8xx.h |    7 ---
 3 files changed, 16 insertions(+), 65 deletions(-)
