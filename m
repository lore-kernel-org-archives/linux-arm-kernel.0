From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jun 2016 18:56:15 -0700
Subject: [GIT PULL 7/7] Broadcom drivers changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1466128575-5378-7-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/drivers

for you to fetch changes up to a536bcc931ed5c047100c3a28f521283749d3b9a:

  soc: brcmstb: fix warning from missing include (2016-06-07 13:53:42 -0700)

----------------------------------------------------------------
This pull request contains drivers related changes for Broadcom SoCs:

- Florian moves drivers/soc/brcmstb to drivers/soc/bcm/brcmstb to be consistent with
  how other SoCs are doing it

- Chris provides a reset driver which is common to the BCM21664 and BCM23550 SoCs

- Ben fixes a warning by providing the appropriate include file

----------------------------------------------------------------
Ben Dooks (1):
      soc: brcmstb: fix warning from missing include

Chris Brand (1):
      power: Introduce Broadcom kona reset driver

Florian Fainelli (1):
      soc: Move brcmstb to bcm/brcmstb

 MAINTAINERS                             |  1 +
 drivers/power/reset/Kconfig             | 10 +++++
 drivers/power/reset/Makefile            |  1 +
 drivers/power/reset/brcm-kona-reset.c   | 73 +++++++++++++++++++++++++++++++++
 drivers/soc/Kconfig                     |  1 -
 drivers/soc/Makefile                    |  1 -
 drivers/soc/bcm/Kconfig                 | 15 +++++++
 drivers/soc/bcm/Makefile                |  1 +
 drivers/soc/{ => bcm}/brcmstb/Makefile  |  0
 drivers/soc/{ => bcm}/brcmstb/biuctrl.c |  1 +
 drivers/soc/{ => bcm}/brcmstb/common.c  |  0
 drivers/soc/brcmstb/Kconfig             | 10 -----
 12 files changed, 102 insertions(+), 12 deletions(-)
 create mode 100644 drivers/power/reset/brcm-kona-reset.c
 rename drivers/soc/{ => bcm}/brcmstb/Makefile (100%)
 rename drivers/soc/{ => bcm}/brcmstb/biuctrl.c (98%)
 rename drivers/soc/{ => bcm}/brcmstb/common.c (100%)
 delete mode 100644 drivers/soc/brcmstb/Kconfig
