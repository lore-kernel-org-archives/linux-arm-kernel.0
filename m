From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Tue, 26 Apr 2011 23:18:45 -0700
Subject: [PATCH 0/2] fix mpp and gpio for pm8921
Message-ID: <1303885127-25220-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discussed here 
https://lkml.org/lkml/2011/4/26/326
removed the usage of mfd_get_data and moved back to using platform_data.

Grant please review and ack these.

Abhijeet Dharmapurikar (1):
  gpio: pm8xxx-gpio: Add pm8xxx gpio driver

David Collins (1):
  mfd: pm8xxx-mpp: Add pm8xxx MPP driver

 drivers/gpio/Kconfig              |   17 ++
 drivers/gpio/Makefile             |    2 +
 drivers/gpio/pm8xxx-gpio.c        |  455 +++++++++++++++++++++++++++++++++++++
 drivers/gpio/pm8xxx-mpp.c         |  325 ++++++++++++++++++++++++++
 drivers/mfd/pm8921-core.c         |   65 ++++++
 include/linux/mfd/pm8xxx/gpio.h   |  135 +++++++++++
 include/linux/mfd/pm8xxx/mpp.h    |  233 +++++++++++++++++++
 include/linux/mfd/pm8xxx/pm8921.h |   18 ++
 8 files changed, 1250 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/pm8xxx-gpio.c
 create mode 100644 drivers/gpio/pm8xxx-mpp.c
 create mode 100644 include/linux/mfd/pm8xxx/gpio.h
 create mode 100644 include/linux/mfd/pm8xxx/mpp.h

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
