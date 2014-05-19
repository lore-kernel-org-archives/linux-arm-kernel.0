From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 May 2014 13:05:58 -0700
Subject: [PATCH RESEND v2 0/3] bus: add Broadcom GISB bus arbiter
 timeout/error handler
Message-ID: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch adds support for the Broadcom GISB bus arbiter timeout/error handler.
GISB is a custom and proprietary bus used in the Broadcom Set Top Box devices
exclusively. The bus arbiter offers the possibly to decode faulting masters as
well as masters that are timing out on the bus.

V2 addresses some comments made by Arnd, and widens the audience by posting
on linux-arm-kernel as well.

These patches should be merged via the 'arm-soc' tree. I am resending those
such that every mailing-list has them in copy.

Thank you!

Florian Fainelli (3):
  bus: add Broadcom GISB arbiter bus timeout/error handler
  Documentation: devicetree: add Broadcom GISB arbiter bindings
  Documentation: sysfs: add Broadcom GISB arbiter sysfs properties

 .../ABI/testing/sysfs-platform-brcmstb-gisb-arb    |   8 +
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |  30 +++
 drivers/bus/Kconfig                                |  11 +-
 drivers/bus/Makefile                               |   1 +
 drivers/bus/brcmstb_gisb.c                         | 289 +++++++++++++++++++++
 5 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-gisb-arb
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 drivers/bus/brcmstb_gisb.c

-- 
1.9.1
