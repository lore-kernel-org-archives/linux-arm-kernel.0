From: jonathar@broadcom.com (Jonathan Richardson)
Date: Fri, 19 Dec 2014 14:17:48 -0800
Subject: [PATCH v2 0/2] Add support for Broadcom iProc touchscreen
In-Reply-To: <Jonathan Richardson <jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
Message-ID: <1419027470-7969-1-git-send-email-jonathar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains initial support for the touchscreen on the Broadcom
iProc family of SoCs. This driver has been validated with Cygnus and is expected
to work on other iProc family of SoCs that use the same touchscreen controller.

Changes from v1:
- Add missing newlines to debug messages
- Use BIT macro for defines
- Fix logic in get_tsc_config to improve readability
- Get rid of unnecessary remove() function

Jonathan Richardson (2):
  Input: touchscreen-iproc: Add Broadcom iProc touchscreen driver
  Input: touchscreen-iproc: add device tree bindings

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |   70 +++
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/bcm_iproc_tsc.c          |  535 ++++++++++++++++++++
 4 files changed, 617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
 create mode 100644 drivers/input/touchscreen/bcm_iproc_tsc.c

-- 
1.7.9.5
