From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:57 +0200
Subject: [PATCH 7/7] arm: Enable support for virtio
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <1287072657-32477-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Qemu can use virtio-pci based devices when emulating a
machine with PCI. This adds the necessary Kconfig entry
that allows users to select those drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8533bbe..319f1a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1179,6 +1179,8 @@ config PCI_HOST_XILINX
 
 source "drivers/pci/Kconfig"
 
+source "drivers/virtio/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
-- 
1.7.1
