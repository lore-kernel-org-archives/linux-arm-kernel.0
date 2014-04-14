From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Mon, 14 Apr 2014 11:55:01 +0200
Subject: ARM: Tidy up DTB Makefile entries
Message-ID: <20140414095501.GA4879@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Few things were out of order:

- removed ARCH_BCM2835 duplicate
- shuffled ARCH_BCM_5301X, ARCH_U8500 and ARCH_U300 around so to keep the
  list sorted

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 arch/arm/boot/dts/Makefile |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: b/arch/arm/boot/dts/Makefile
===================================================================
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,10 +51,9 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dt
 
 dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
-dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2-sony-nsz-gs7.dtb	\
 	berlin2cd-google-chromecast.dtb
@@ -294,13 +293,6 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.
 dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-apq8074-dragonboard.dtb
-dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
-	ste-hrefprev60-stuib.dtb \
-	ste-hrefprev60-tvk.dtb \
-	ste-hrefv60plus-stuib.dtb \
-	ste-hrefv60plus-tvk.dtb \
-	ste-ccu8540.dtb \
-	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
@@ -369,9 +361,16 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harm
 	tegra30-cardhu-a04.dtb \
 	tegra114-dalmore.dtb \
 	tegra124-venice2.dtb
+dtb-$(CONFIG_ARCH_U300) += ste-u300.dtb
+dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
+	ste-hrefprev60-stuib.dtb \
+	ste-hrefprev60-tvk.dtb \
+	ste-hrefv60plus-stuib.dtb \
+	ste-hrefv60plus-tvk.dtb \
+	ste-ccu8540.dtb \
+	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += versatile-ab.dtb \
 	versatile-pb.dtb
-dtb-$(CONFIG_ARCH_U300) += ste-u300.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
