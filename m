From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 Oct 2017 17:16:36 -0700
Subject: [GIT PULL 5/5] Broadcom drivers changes for 4.15 (part 2)
In-Reply-To: <20171021001636.17662-1-f.fainelli@gmail.com>
References: <20171021001636.17662-1-f.fainelli@gmail.com>
Message-ID: <20171021001636.17662-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0e9b11413262ef3d64273e15f7631d9836c53c1a:

  soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS) (2017-09-25 11:47:14 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/drivers-part2

for you to fetch changes up to 04c3767f10809797331cda78808d9163939081e1:

  clk: bcm: Add Broadcom Hurricane 2 clock support (2017-10-12 11:31:46 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64/MIPS SoCs changes for 4.15
(second part), please pull the following:

- Markus updates the Broadcom STB DPFE driver to avoid loading the firmware when
  unnecessary to accomodate for specific platform restrictions

- Florian adds support for the Broadcom Hurricane 2 SoC iProc PLL clock needed
  to get the proper CPU clock frequency

----------------------------------------------------------------
Florian Fainelli (1):
      clk: bcm: Add Broadcom Hurricane 2 clock support

Markus Mayer (2):
      memory: brcmstb: dpfe: introduce is_dcpu_enabled()
      memory: brcmstb: dpfe: skip downloading firmware when possible

 drivers/clk/bcm/Kconfig       |  9 +++++++++
 drivers/clk/bcm/Makefile      |  1 +
 drivers/clk/bcm/clk-hr2.c     | 27 +++++++++++++++++++++++++++
 drivers/memory/brcmstb_dpfe.c | 37 +++++++++++++++++++++++++++++--------
 4 files changed, 66 insertions(+), 8 deletions(-)
 create mode 100644 drivers/clk/bcm/clk-hr2.c
