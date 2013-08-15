From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 15 Aug 2013 18:55:30 +0800
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
Message-ID: <1376564133-11286-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We meet some boards having a lot of pin conflicts between different devices,
only one of them can be enabled to run at one time.

e.g. imx6q sabreauto board, i2c, spi, weim, flexcan, uart and etc involved
with pin conflict.

Instead of changing dts manually or adding a lot dts files according to
different device availability, we provide feature to dynamically update the
device node status via command line, then those devices involved with
pin conflict can be enabled or disabled dynamically.

It's conveniently to use and can save a lot dts board files, also can
permenantly fix the pin conflicts issue.

The patch series is based on v3.11-rc5.

Dong Aisheng (3):
  of: add device node status update APIs
  of: add update device node status via cmdline feature
  of: add node status update via name format with cmdline

 Documentation/kernel-parameters.txt |   10 +++
 drivers/of/base.c                   |  107 +++++++++++++++++++++++++++++++++
 drivers/of/fdt.c                    |  111 +++++++++++++++++++++++++++++++++++
 include/linux/of.h                  |   13 ++++
 4 files changed, 241 insertions(+), 0 deletions(-)
