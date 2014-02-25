From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue, 25 Feb 2014 14:22:25 +0200
Subject: [PATCHv2 0/5] net: rfkill: gpio: cleanup and a few new acpi ids
Message-ID: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Removed the gpio entries from arch/arm/mach-tegra/board-paz00.c

Hi,

I was waiting for the DT support from Chen-Yu before sending these,
but decided it makes no difference when I send them. I'm dropping the
con ID in the second patch because Dan noticed the warning, but of
course it will mean the "gpios" property can be used with DT.

The two last patches just add ACPI IDs for some new Baytrail based
boards.


Heikki Krogerus (5):
  ARM: tegra: remove obsolete gpio entries
  net: rfkill: gpio: remove unused and obsolete platform parameters
  net: rfkill: gpio: remove gpio names
  net: rfkill: gpio: add ACPI ID for GPS module on Lenove Miix2
  net: rfkill: gpio: add ACPI IDs for a Broadcom bluetooth chip

 arch/arm/mach-tegra/board-paz00.c |  4 +---
 include/linux/rfkill-gpio.h       | 10 ----------
 net/rfkill/rfkill-gpio.c          | 40 +++++++++------------------------------
 3 files changed, 10 insertions(+), 44 deletions(-)

-- 
1.9.0.rc3
