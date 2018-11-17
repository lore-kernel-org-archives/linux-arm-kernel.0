From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 17 Nov 2018 10:11:30 -0800
Subject: [PATCH 0/1] Reset controller support for i.MX8MQ
Message-ID: <20181117181131.9330-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everyone:

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs (full tree can be found at [github-v0]). This patch is _very_
preliminary and by no means is ready for inclusion (it also has some
unmet dependencies).  However is should be in OK enough shape to get
some early feedback on, which is the intent of this submission.

Specifically, I'd like to get some feedback on whether the approach of
having a single shared reset lookup table is acceptable or not.

All other feedback is appreciated as well!

Thank you,
Andrey Smirnov

[github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0

Andrey Smirnov (1):
  reset: imx7: Add support for i.MX8MQ

 drivers/reset/Kconfig                   |  2 +-
 drivers/reset/reset-imx7.c              | 66 ++++++++++++++++++++++++-
 include/dt-bindings/reset/imx7-reset.h  | 15 +++++-
 include/dt-bindings/reset/imx8m-reset.h | 47 ++++++++++++++++++
 4 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8m-reset.h

-- 
2.19.1
