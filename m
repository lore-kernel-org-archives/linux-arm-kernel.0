From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 15:53:45 +0200
Subject: [PATCH v2 0/4] usb: chipidea: fix error handling and add dr_role
 property
Message-ID: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

while hacking on the chipidea driver, I fixed the error path in
the udc part of the chipidea driver. Further I added the possibility
to limit the driver to host or device only mode. It's possible via
platformdata and device tree. For dt I selected the dr_role property
which is already used for other dual role usb drivers.

Changes since v1:
- rebase to Richard's Tree
  https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
- remove redundant wording from devicetree binding documentation
- move dtsi changes into seperate patch
- also change imx23.dtsi
- tested on compile time non OF tree platforms (amd64)
  of.h provides proper stubs.

regards, Marc
