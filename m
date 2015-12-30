From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Dec 2015 09:55:44 +0900
Subject: [PATCH v2 0/3] arm: beaglex15: fix USB Gadget
Message-ID: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset make the extcon-palmas.c more generic style and then send v2
patchset. I add the Felipe comment of v1 patchset as following:
But, I have not test on real board because I don't have it.
Just, I modify this patchset based on v1 patchset[1] from Felipe Balbi.

- Felipe comment of this patchset:
"Hi,

with the following patches I can get USB Gadget working
with my beagle x15 with today's Linus' tree.

regards".

[1] https://lkml.org/lkml/2015/11/12/508

Changes from v1:
(https://lkml.org/lkml/2015/11/12/508)
- Refactoring the extcon-palmas.c driver with more generic style to support
  the VBUS gpio pin.
- Use the 'vbus-gpio' property instead of 'interrupts-extended']

Felipe Balbi (3):
  extcon: palmas: Add the support for VBUS detection by using GPIO
  arm: boot: dts: beaglex15: Remove ID GPIO
  arm: boot: beaglex15: pass correct interrupt

 arch/arm/boot/dts/am57xx-beagle-x15.dts |  3 +-
 drivers/extcon/extcon-palmas.c          | 50 +++++++++++++++++++++++++++++++++
 include/linux/mfd/palmas.h              |  3 ++
 3 files changed, 54 insertions(+), 2 deletions(-)

-- 
1.9.1
