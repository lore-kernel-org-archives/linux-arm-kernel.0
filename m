From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 12 Jan 2018 13:08:13 -0800
Subject: [PATCH 0/2] soc: brcmstb: Fix multi-platform issues
Message-ID: <20180112210815.9684-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This incorporates Sudeep's and Thierry's changes and makes minor tweaks
such that we don't return errors from initcalls even if we are not
running on Broadcom STB platforms.

I kept your authorship because you did 99% of the work, and I just added a
proper Fixes: tag to the first patch and combined Thierry's 4 patches into one.

This has now been properly tested by booting a QEMU ARM virtual machine to verify
we are not seeing BRCMSTB related messages anymore.

Again, sorry for missing the multi-platform kernel case!

Thank you!

Sudeep Holla (1):
  soc: brcmstb: biuctrl: exit without warning on non brcmstb platforms

Thierry Reding (1):
  soc: bcm: brcmstb: Be multi-platform compatible

 drivers/soc/bcm/brcmstb/biuctrl.c | 20 +++++++++++---------
 drivers/soc/bcm/brcmstb/common.c  | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 18 deletions(-)

-- 
2.14.1
