From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 20:36:00 +0100
Subject: [PATCHv4 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
In-Reply-To: <Pine.LNX.4.44L0.1501181220040.1499-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1501181220040.1499-100000@netrider.rowland.org>
Message-ID: <1421609766-11204-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend/resume support for EHCI.
struct dev_pm_ops for OHCI.
PLL stop for all sleep modes for OHCI.
Removed global variables from both.
Removed at91_suspend_entering_slow_clock() from both.

Changes since v3:
  * Using struct dev_pm_ops instead of static struct platform_driver
    resume and suspend bindings for both EHCI and OHCI
  * Fixed inconsistency in patch subjects, _ intead of - for file names
  * Patch cleaning with the help of checkpatch.pl, fixed lines over
    80 characters

Changes since v2:
  * Added patchs from an other submission, because this series
    depended on this one
    * EHCI: Move global variables to private struct
    * OHCI: Move global variables to private struct
  * Using ohci->priv and ehci->priv instead of hcd->hcd_priv,
    which were not the right way to do that

Changes since v1:
  * Don't use at91_suspend_entering_slow_clock() on EHCI,
    we are trying to get read of this of this function
  * Removed at91_suspend_entering_slow_clock() from OHCI

Sylvain Rochet (6):
  USB: host: ehci-atmel: Add suspend/resume support
  USB: host: ohci-at91: Use struct dev_pm_ops instead of struct
    platform_driver
  USB: host: ohci-at91: Stop/start USB PLL for all sleep modes
  USB: host: ehci-atmel: Move global variables to private struct
  USB: host: ohci-at91: Move global variables to private struct
  USB: host: ohci-at91: usb_hcd_at91_probe(), remove useless stack
    initialisation

 drivers/usb/host/ehci-atmel.c | 102 +++++++++++++++++++++++++---------
 drivers/usb/host/ohci-at91.c  | 126 ++++++++++++++++++++++++------------------
 2 files changed, 149 insertions(+), 79 deletions(-)

-- 
2.1.4
