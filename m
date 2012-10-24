From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Oct 2012 15:49:19 +0200
Subject: [PATCH 0/2] Adding SATA support for Armada 370/XP
Message-ID: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this small patch set adds the SATA support for Armada 370 and Armada XP.

The evaluation boards for Armada 370 and Armada XP come with 2 SATA
ports, and when both are enable the coherent pool for DMA mapping was
too short. It was exactly the same issue that was fixed for Kirkwood
two months ago. So I used the same fix in the first patch. Later when
Kirkwood will be part of mach-mvebu, then this fix will be shared
between the 2 SoCs families.

This patch set is based on 3.7-rc2 and depends one the framework clock
support (the last version was posted last week:
http://thread.gmane.org/gmane.linux.kernel/1375701). The git branch
called mvebu-SATA-for-3.8 is also available at
https://github.com/MISL-EBU-System-SW/mainline-public.git.

Regards,

Gregory

Gregory CLEMENT (1):
  arm: mvebu: increase atomic coherent pool size for armada 370/XP

Lior Amsalem (1):
  arm: mvebu: adding SATA support: dt binding and config update

 arch/arm/boot/dts/armada-370-db.dts  |    3 +++
 arch/arm/boot/dts/armada-370-xp.dtsi |   10 ++++++++++
 arch/arm/boot/dts/armada-xp-db.dts   |    3 +++
 arch/arm/configs/mvebu_defconfig     |    7 +++++++
 arch/arm/mach-mvebu/armada-370-xp.c  |   12 ++++++++++++
 5 files changed, 35 insertions(+)

-- 
1.7.9.5
