From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Fri, 4 Jan 2013 15:24:35 +0530
Subject: [PATCH V2 0/2] ARM/ASoC: Davinci: Device Tree Update
Message-ID: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Add pinctrl for McASP Module
2. Add DT support for Davinci machine platform

This patch-set is tested on Davinci platform (DA850 EVM). This series applies on
top of tag next-20130103 git tree
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

These patches cannot be tested directly on mainline kernel (DT based).
This is because dma is not yet completely ported to Davinci ASoC. I had to add
few hacks to get Audio working on Davinci DA850 platform.

For reference, I have placed the entire working tree @ 
Tree : https://gitorious.org/davinci-asoc-dt/davinci-asoc-dt
Branch : dev_next-20130103_davinci_asoc_dt

Changes in V2
	 - Remove reference to Linux & software details from DT binding

Hebbar, Gururaja (2):
  ASoC: davinci-mcasp: Add pinctrl support
  ASoC: Davinci: machine: Add device tree binding

 .../bindings/sound/davinci-evm-audio.txt           |   53 ++++++
 sound/soc/davinci/davinci-evm.c                    |  179 +++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.c                  |    7 +
 3 files changed, 219 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5
