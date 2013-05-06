From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon,  6 May 2013 12:52:26 +0530
Subject: [PATCHv2 0/4] mailbox: Common API
Message-ID: <1367824946-6160-1-git-send-email-jaswinder.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
  I have made the implementation look more proper. Also made some changes
suggested by Suman. Changes since V1:

* Delete timer upon mailbox release
* Filled in the stub ipc_links_unregister()
* Check kzalloc return for errors.
* Add the controller driver for OMAP2 class. I have taken the patch
  for mailbox's hwmod from Suman's. The clients are yet to be converted
  but this should be enough to convey the idea that the API could
  work for OMAP as well. If I had access to STE documentation, I might
  have done some implementation for U8500 as well.

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   12 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   11 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   11 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   13 +
 drivers/cpufreq/highbank-cpufreq.c         |   22 +-
 drivers/mailbox/Kconfig                    |    9 +
 drivers/mailbox/Makefile                   |    7 +-
 drivers/mailbox/mailbox.c                  |  494 ++++++++++++++++++++++++++++
 drivers/mailbox/omap2.c                    |  420 +++++++++++++++++++++++
 drivers/mailbox/pl320-ipc.c                |  198 -----------
 drivers/mailbox/pl320.c                    |  212 ++++++++++++
 include/linux/mailbox.h                    |   28 +-
 include/linux/mailbox_client.h             |   85 +++++
 include/linux/mailbox_controller.h         |  102 ++++++
 include/linux/platform_data/mailbox-omap.h |   64 ++++
 15 files changed, 1473 insertions(+), 215 deletions(-)

Cheers,
-Jassi
