From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 29 Dec 2009 14:19:33 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.33-rc2
In-Reply-To: <f17812d70912282218n77e1fe38tdb6259059cbe8eac@mail.gmail.com>
References: <f17812d70912282218n77e1fe38tdb6259059cbe8eac@mail.gmail.com>
Message-ID: <f17812d70912282219m580f7aeeo500b1d037a1649bf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit 6b7b284958d47b77d06745b36bc7f36dab769d9b:
?Linus Torvalds (1):
? ? ? ?Linux 2.6.33-rc2

are available in the git repository at:

?git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Eric Miao (2):
? ? ?[ARM] pxafb: fix building issue of incorrect reference
? ? ?[ARM] pxa/poodle: fix incorrect 'gpio_card_detect' of MMC

H Hartley Sweeten (1):
? ? ?[ARM] pxa: use resource_size() in pwm.c

Haojian Zhuang (1):
? ? ?[ARM] pxa/zylonite: simplify reduntant gpio settings on mmc slot

Marc Zyngier (3):
? ? ?[ARM] pxa/zeus: make internal zeus_get_pcb_info static
? ? ?[ARM] pxa/zeus: relax memory timings on Zeus ethernet ports
? ? ?[ARM] pxa/zeus: provide power-source information when APM is enabled

Marek Vasut (2):
? ? ?[ARM] pxa/littleton: add UART3 GPIO config
? ? ?[ARM] pxa/littleton: select CPU_PXA300 and CPU_PXA310

Uwe Kleine-K?nig (1):
? ? ?[ARM] pxa/ttc_dkb: remove duplicate macro definition

?arch/arm/mach-mmp/ttc_dkb.c ? ? ? ? ? ? ? | ? ?2 -
?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? | ? ?2 +
?arch/arm/mach-pxa/include/mach/zylonite.h | ? ?7 --
?arch/arm/mach-pxa/littleton.c ? ? ? ? ? ? | ? ?6 ++
?arch/arm/mach-pxa/poodle.c ? ? ? ? ? ? ? ?| ? ?2 +-
?arch/arm/mach-pxa/zeus.c ? ? ? ? ? ? ? ? ?| ? 36 +++++++++++-
?arch/arm/mach-pxa/zylonite.c ? ? ? ? ? ? ?| ? 87 +++++------------------------
?arch/arm/mach-pxa/zylonite_pxa300.c ? ? ? | ? 12 +---
?arch/arm/mach-pxa/zylonite_pxa320.c ? ? ? | ? ?4 -
?arch/arm/plat-pxa/pwm.c ? ? ? ? ? ? ? ? ? | ? ?8 +-
?drivers/video/pxafb.c ? ? ? ? ? ? ? ? ? ? | ? ?4 +-
?11 files changed, 64 insertions(+), 106 deletions(-)
