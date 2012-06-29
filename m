From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 29 Jun 2012 18:52:54 +0800
Subject: [PATCH v9 00/14] add imx usb driver based on Greg next tree
In-Reply-To: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
References: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <02d626b8-b090-408a-b307-17ebe354aa37@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is v9. Sorry for mistake.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Richard Zhao <richard.zhao@freescale.com> wrote:

The work is based on ci13xxx rework done by Alexander Shishkin.

To let Greg pick up, I also added patches Alex queued that I depends on.

This patch series can also be found at:
https://github.com/riczhao/kernel-imx/commits/topics/usb-driver

Status:
- this version only support host
- usbotg controler works at host role

Changes since last version:
- mxs_phy: fix build warnings
- ci13xxx_imx: add pm_runtime_disable at exit path

Alexander Shishkin (1):
usb: chipidea: remove unneeded NULL check

Felipe Balbi (3):
usb: chipidea: drop useless arch-check
usb: chipidea: msm: add missing section annotation
usb: chipidea: msm: add remove method

Richard Zhao (10):
USB: Chipidea: rename struct ci13xxx_udc_driver to struct
ci13xxx_platform_data
USB: Chipidea: rename struct ci13xxx variables from udc to ci
USB: Chipidea: add unified ci13xxx_{add,remove}_device for platform
drivers
USB: Chipidea: add ci13xxx device id management
usb: chipidea: select USB_EHCI_ROOT_HUB_TT in USB_CHIPIDEA_HOST of
Kconfig
usb: otg: add notify_connect/notify_disconnect callback
USB: notify phy when root hub port connect change
usb: chipidea: permit driver bindings pass phy pointer
usb: otg: add basic mxs phy driver support
usb: chipidea: add imx platform driver

.../devicetree/bindings/usb/ci13xxx-imx.txt | 18 +
Documentation/devicetree/bindings/usb/mxs-phy.txt | 13 +
drivers/usb/chipidea/Kconfig | 1 +
drivers/usb/chipidea/Makefile | 9 +-
drivers/usb/chipidea/ci.h | 32 +-
drivers/usb/chipidea/ci13xxx_imx.c | 198 ++++++
drivers/usb/chipidea/ci13xxx_msm.c | 63 +-
drivers/usb/chipidea/ci13xxx_pci.c | 52 +-
drivers/usb/chipidea/core.c | 70 ++-
drivers/usb/chipidea/debug.c | 146 ++---
drivers/usb/chipidea/host.c | 3 +-
drivers/usb/chipidea/udc.c | 634 ++++++++++----------
drivers/usb/core/hub.c | 8 +
drivers/usb/otg/Kconfig | 10 +
drivers/usb/otg/Makefile | 1 +
drivers/usb/otg/mxs-phy.c | 186 ++++++
include/linux/usb/chipidea.h | 14 +-
include/linux/usb/otg.h | 21 +
18 files changed, 989 insertions(+), 490 deletions(-)
create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
create mode 100644 Documentation/devicetree/bindings/usb/mxs-phy.txt
create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
create mode 100644 drivers/usb/otg/mxs-phy.c

-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/d08595a4/attachment-0001.html>
