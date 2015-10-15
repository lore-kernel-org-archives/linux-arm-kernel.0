From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 15 Oct 2015 18:22:15 +0200
Subject: [PATCH] ARM: configs: Enable FIXED_PHY in multi_v7 defconfig
Message-ID: <1444926135-26513-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FIXED_PHY is needed to have Ethernet working on STi boards.

Select it as built-in since RootFS is accessible from NFS on these boards.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
Hi Arnd, Olof,

Could you please apply it directly as this is the only defconfig patch I have in my
queue for v4.4.

Thanks,
Maxime
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..76ce528 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -220,6 +220,7 @@ CONFIG_SMSC_PHY=y
 CONFIG_BROADCOM_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
+CONFIG_FIXED_PHY=y
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
-- 
1.9.1
