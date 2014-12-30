From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 30 Dec 2014 06:20:27 +0000
Subject: [PATCH V2] ARM: dts: Only build dtb if associated Arch and/or SoC is
 enabled
Message-ID: <1419920427-29121-1-git-send-email-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of arches (EXYNOS/IMX/TEGRA) are separated out into finer grained
definitions whether it be sub ARCH or SOC definitions. The device tree blobs
should only be built if the specific option is enabled that supports that
device or it might be that there's an expectation that the device is supported
when in actual fact it's not. This ensures only the relevant bits are built.

Also standardised the line break between the arch/soc definitions and the
dtbs to be on separate lines for better consistency as per feedback.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/Makefile | 213 ++++++++++++++++++++++++++++++---------------
 1 file changed, 141 insertions(+), 72 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..5873b3e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,33 +51,43 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
 # sama5d4
 dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4ek.dtb
 
-dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
-dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
+dtb-$(CONFIG_ARCH_ATLAS6) += \
+	atlas6-evb.dtb
+dtb-$(CONFIG_ARCH_AXXIA) += \
+	axm5516-amarillo.dtb
+dtb-$(CONFIG_ARCH_BCM2835) += \
+	bcm2835-rpi-b.dtb \
+	bcm2835-rpi-b-plus.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
 	bcm4708-netgear-r6250.dtb \
 	bcm4708-netgear-r6300-v2.dtb \
 	bcm47081-asus-rt-n18u.dtb \
 	bcm47081-buffalo-wzr-600dhp2.dtb
-dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
-dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
+dtb-$(CONFIG_ARCH_BCM_63XX) += \
+	bcm963138dvt.dtb
+dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
+	bcm911360_entphn.dtb \
 	bcm911360k.dtb \
 	bcm958300k.dtb
-dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm28155-ap.dtb \
+dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
+	bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
-	berlin2-sony-nsz-gs7.dtb	\
-	berlin2cd-google-chromecast.dtb	\
+	berlin2-sony-nsz-gs7.dtb \
+	berlin2cd-google-chromecast.dtb \
 	berlin2q-marvell-dmp.dtb
 dtb-$(CONFIG_ARCH_BRCMSTB) += \
 	bcm7445-bcm97445svmb.dtb
-dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
+dtb-$(CONFIG_ARCH_DAVINCI) += \
+	da850-enbw-cmc.dtb \
 	da850-evm.dtb
-dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
-dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
-	exynos3250-rinato.dtb \
+dtb-$(CONFIG_ARCH_EFM32) += \
+	efm32gg-dk3750.dtb
+dtb-$(CONFIG_ARCH_EXYNOS3) += \
+	exynos3250-monk.dtb \
+	exynos3250-rinato.dtb
+dtb-$(CONFIG_ARCH_EXYNOS4) += \
 	exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
@@ -88,7 +98,8 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
 	exynos4412-origen.dtb \
 	exynos4412-smdk4412.dtb \
 	exynos4412-tiny4412.dtb \
-	exynos4412-trats2.dtb \
+	exynos4412-trats2.dtb
+dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5250-arndale.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
@@ -101,17 +112,24 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
-dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
-dtb-$(CONFIG_ARCH_HIX5HD2) += hisi-x5hd2-dkb.dtb
-dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
+dtb-$(CONFIG_ARCH_HI3xxx) += \
+	hi3620-hi4511.dtb
+dtb-$(CONFIG_ARCH_HIX5HD2) += \
+	hisi-x5hd2-dkb.dtb
+dtb-$(CONFIG_ARCH_HIGHBANK) += \
+	highbank.dtb \
 	ecx-2000.dtb
-dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
-dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
+dtb-$(CONFIG_ARCH_HIP04) += \
+	hip04-d01.dtb
+dtb-$(CONFIG_ARCH_INTEGRATOR) += \
+	integratorap.dtb \
 	integratorcp.dtb
-dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
+dtb-$(CONFIG_ARCH_KEYSTONE) += \
+	k2hk-evm.dtb \
 	k2l-evm.dtb \
 	k2e-evm.dtb
-dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
+dtb-$(CONFIG_MACH_KIRKWOOD) += \
+	kirkwood-b3.dtb \
 	kirkwood-cloudbox.dtb \
 	kirkwood-d2net.dtb \
 	kirkwood-db-88f6281.dtb \
@@ -174,37 +192,49 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-ts419-6281.dtb \
 	kirkwood-ts419-6282.dtb
-dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
-dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
-dtb-$(CONFIG_MACH_MESON6) += meson6-atv1200.dtb
-dtb-$(CONFIG_ARCH_MMP) += pxa168-aspenite.dtb \
+dtb-$(CONFIG_ARCH_LPC32XX) += \
+	ea3250.dtb phy3250.dtb
+dtb-$(CONFIG_ARCH_MARCO) += \
+	marco-evb.dtb
+dtb-$(CONFIG_MACH_MESON6) += \
+	meson6-atv1200.dtb
+dtb-$(CONFIG_ARCH_MMP) += \
+	pxa168-aspenite.dtb \
 	pxa910-dkb.dtb \
 	mmp2-brownstone.dtb
-dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
-dtb-$(CONFIG_ARCH_MXC) += \
+dtb-$(CONFIG_ARCH_MOXART) += \
+	moxart-uc7112lx.dtb
+dtb-$(CONFIG_SOC_IMX1) += \
 	imx1-ads.dtb \
-	imx1-apf9328.dtb \
+	imx1-apf9328.dtb
+dtb-$(CONFIG_SOC_IMX25) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
 	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb \
 	imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb \
 	imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
 	imx25-karo-tx25.dtb \
-	imx25-pdk.dtb \
+	imx25-pdk.dtb
+dtb-$(CONFIG_SOC_IMX31) += \
 	imx27-apf27.dtb \
 	imx27-apf27dev.dtb \
 	imx27-eukrea-mbimxsd27-baseboard.dtb \
 	imx27-pdk.dtb \
 	imx27-phytec-phycore-rdk.dtb \
-	imx27-phytec-phycard-s-rdk.dtb \
-	imx31-bug.dtb \
+	imx27-phytec-phycard-s-rdk.dtb
+dtb-$(CONFIG_SOC_IMX31) += \
+	imx31-bug.dtb
+dtb-$(CONFIG_SOC_IMX35) += \
 	imx35-eukrea-mbimxsd35-baseboard.dtb \
-	imx35-pdk.dtb \
-	imx50-evk.dtb \
+	imx35-pdk.dtb
+dtb-$(CONFIG_SOC_IMX50) += \
+	imx50-evk.dtb
+dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
 	imx51-babbage.dtb \
 	imx51-digi-connectcore-jsk.dtb \
-	imx51-eukrea-mbimxsd51-baseboard.dtb \
+	imx51-eukrea-mbimxsd51-baseboard.dtb
+dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-m53evk.dtb \
 	imx53-mba53.dtb \
@@ -213,7 +243,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-smd.dtb \
 	imx53-tx53-x03x.dtb \
 	imx53-tx53-x13x.dtb \
-	imx53-voipac-bsb.dtb \
+	imx53-voipac-bsb.dtb
+dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-aristainetos_4.dtb \
 	imx6dl-aristainetos_7.dtb \
 	imx6dl-cubox-i.dtb \
@@ -264,16 +295,21 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-tx6q-1010-comtft.dtb \
 	imx6q-tx6q-1020.dtb \
 	imx6q-tx6q-1020-comtft.dtb \
-	imx6q-tx6q-1110.dtb \
-	imx6sl-evk.dtb \
+	imx6q-tx6q-1110.dtb
+dtb-$(CONFIG_SOC_IMX6SL) += \
+	imx6sl-evk.dtb
+dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sdb.dtb \
+dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-qds.dtb \
-	ls1021a-twr.dtb \
+	ls1021a-twr.dtb
+dtb-$(CONFIG_SOC_VF610) += \
 	vf500-colibri-eval-v3.dtb \
 	vf610-colibri-eval-v3.dtb \
 	vf610-cosmic.dtb \
 	vf610-twr.dtb
-dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
+dtb-$(CONFIG_ARCH_MXS) += \
+	imx23-evk.dtb \
 	imx23-olinuxino.dtb \
 	imx23-stmp378x_devb.dtb \
 	imx28-apf28.dtb \
@@ -294,17 +330,21 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
 	imx28-tx28.dtb
-dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb \
+dtb-$(CONFIG_ARCH_NOMADIK) += \
+	ste-nomadik-s8815.dtb \
 	ste-nomadik-nhk15.dtb
-dtb-$(CONFIG_ARCH_NSPIRE) += nspire-cx.dtb \
+dtb-$(CONFIG_ARCH_NSPIRE) += \
+	nspire-cx.dtb \
 	nspire-tp.dtb \
 	nspire-clp.dtb
-dtb-$(CONFIG_ARCH_OMAP2) += omap2420-h4.dtb \
+dtb-$(CONFIG_ARCH_OMAP2) += \
+	omap2420-h4.dtb \
 	omap2420-n800.dtb \
 	omap2420-n810.dtb \
 	omap2420-n810-wimax.dtb \
 	omap2430-sdp.dtb
-dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
+dtb-$(CONFIG_ARCH_OMAP3) += \
+	am3517-craneboard.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
 	omap3430-sdp.dtb \
@@ -348,7 +388,8 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-sbc-t3730.dtb \
 	omap3-thunder.dtb \
 	omap3-zoom3.dtb
-dtb-$(CONFIG_SOC_AM33XX) += am335x-base0033.dtb \
+dtb-$(CONFIG_SOC_AM33XX) += \
+	am335x-base0033.dtb \
 	am335x-bone.dtb \
 	am335x-boneblack.dtb \
 	am335x-evm.dtb \
@@ -356,7 +397,8 @@ dtb-$(CONFIG_SOC_AM33XX) += am335x-base0033.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
 	am335x-lxm.dtb
-dtb-$(CONFIG_ARCH_OMAP4) += omap4-duovero-parlor.dtb \
+dtb-$(CONFIG_ARCH_OMAP4) += \
+	omap4-duovero-parlor.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
@@ -364,20 +406,25 @@ dtb-$(CONFIG_ARCH_OMAP4) += omap4-duovero-parlor.dtb \
 	omap4-sdp-es23plus.dtb \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb
-dtb-$(CONFIG_SOC_AM43XX) += am43x-epos-evm.dtb \
+dtb-$(CONFIG_SOC_AM43XX) += \
+	am43x-epos-evm.dtb \
 	am437x-sk-evm.dtb \
 	am437x-gp-evm.dtb
-dtb-$(CONFIG_SOC_OMAP5) += omap5-cm-t54.dtb \
+dtb-$(CONFIG_SOC_OMAP5) += \
+	omap5-cm-t54.dtb \
 	omap5-sbc-t54.dtb \
 	omap5-uevm.dtb
-dtb-$(CONFIG_SOC_DRA7XX) += dra7-evm.dtb \
+dtb-$(CONFIG_SOC_DRA7XX) += \
+	dra7-evm.dtb \
 	am57xx-beagle-x15.dtb \
 	dra72-evm.dtb
-dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
+dtb-$(CONFIG_ARCH_ORION5X) += \
+	orion5x-lacie-d2-network.dtb \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
 	orion5x-maxtor-shared-storage-2.dtb \
 	orion5x-rd88f5182-nas.dtb
-dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
+dtb-$(CONFIG_ARCH_PRIMA2) += \
+	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
@@ -388,17 +435,21 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb
-dtb-$(CONFIG_ARCH_REALVIEW) += arm-realview-pb1176.dtb
+dtb-$(CONFIG_ARCH_REALVIEW) += \
+	arm-realview-pb1176.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-bqcurie2.dtb \
 	rk3066a-marsboard.dtb \
 	rk3188-radxarock.dtb \
 	rk3288-evb-act8846.dtb \
 	rk3288-evb-rk808.dtb
-dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
-dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
+dtb-$(CONFIG_ARCH_S3C24XX) += \
+	s3c2416-smdk2416.dtb
+dtb-$(CONFIG_ARCH_S3C64XX) += \
+	s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
-dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
+dtb-$(CONFIG_ARCH_S5PV210) += \
+	s5pv210-aquila.dtb \
 	s5pv210-goni.dtb \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
@@ -414,7 +465,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	sh7372-mackerel.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
+	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7779-marzen.dtb \
@@ -422,20 +474,25 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7794-alt.dtb
-dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
+dtb-$(CONFIG_ARCH_SOCFPGA) += \
+	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
 	socfpga_vt.dtb
-dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
+dtb-$(CONFIG_ARCH_SPEAR13XX) += \
+	spear1310-evb.dtb \
 	spear1340-evb.dtb
-dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
+dtb-$(CONFIG_ARCH_SPEAR3XX) += \
+	spear300-evb.dtb \
 	spear310-evb.dtb \
 	spear320-evb.dtb \
 	spear320-hmi.dtb
-dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
-dtb-$(CONFIG_ARCH_STI)+= stih407-b2120.dtb \
+dtb-$(CONFIG_ARCH_SPEAR6XX) += \
+	spear600-evb.dtb
+dtb-$(CONFIG_ARCH_STI) += \
+	stih407-b2120.dtb \
 	stih410-b2120.dtb \
 	stih415-b2000.dtb \
 	stih415-b2020.dtb \
@@ -477,7 +534,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-ippo-q8h-v5.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb
-dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
+	tegra20-harmony.dtb \
 	tegra20-iris-512.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
@@ -486,34 +544,43 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-tec.dtb \
 	tegra20-trimslice.dtb \
 	tegra20-ventana.dtb \
-	tegra20-whistler.dtb \
+	tegra20-whistler.dtb
+dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-apalis-eval.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
-	tegra30-colibri-eval-v3.dtb \
+	tegra30-colibri-eval-v3.dtb
+dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
 	tegra114-dalmore.dtb \
 	tegra114-roth.dtb \
-	tegra114-tn7.dtb \
+	tegra114-tn7.dtb
+dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
 	tegra124-jetson-tk1.dtb \
 	tegra124-nyan-big.dtb \
 	tegra124-venice2.dtb
-dtb-$(CONFIG_ARCH_U300) += ste-u300.dtb
-dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
+dtb-$(CONFIG_ARCH_U300) += \
+	ste-u300.dtb
+dtb-$(CONFIG_ARCH_U8500) += \
+	ste-snowball.dtb \
 	ste-hrefprev60-stuib.dtb \
 	ste-hrefprev60-tvk.dtb \
 	ste-hrefv60plus-stuib.dtb \
 	ste-hrefv60plus-tvk.dtb \
 	ste-ccu8540.dtb \
 	ste-ccu9540.dtb
-dtb-$(CONFIG_ARCH_VERSATILE) += versatile-ab.dtb \
+dtb-$(CONFIG_ARCH_VERSATILE) += \
+	versatile-ab.dtb \
 	versatile-pb.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
+dtb-$(CONFIG_ARCH_VEXPRESS) += \
+	vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
 	vexpress-v2p-ca15_a7.dtb
-dtb-$(CONFIG_ARCH_VIRT) += xenvm-4.2.dtb
-dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
+dtb-$(CONFIG_ARCH_VIRT) += \
+	xenvm-4.2.dtb
+dtb-$(CONFIG_ARCH_VT8500) += \
+	vt8500-bv07.dtb \
 	wm8505-ref.dtb \
 	wm8650-mid.dtb \
 	wm8750-apc8750.dtb \
@@ -545,13 +612,15 @@ dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-netgear-rn2120.dtb \
 	armada-xp-openblocks-ax3-4.dtb \
 	armada-xp-synology-ds414.dtb
-dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
+dtb-$(CONFIG_MACH_DOVE) += \
+	dove-cm-a510.dtb \
 	dove-cubox.dtb \
 	dove-cubox-es.dtb \
 	dove-d2plug.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb \
+dtb-$(CONFIG_ARCH_MEDIATEK) += \
+	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
-- 
2.1.0
