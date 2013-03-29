From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 29 Mar 2013 20:19:36 +0100
Subject: [PATCH 1/1] ARM: boot/dts/Makefile: drop '\'
Message-ID: <1364584776-30413-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when adding multiple new platform this generate comflict
so drop it

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/Makefile |  456 ++++++++++++++++++++++++++------------------
 1 file changed, 268 insertions(+), 188 deletions(-)
 rewrite arch/arm/boot/dts/Makefile (67%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
dissimilarity index 67%
index 9c62558..ed4c7c2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,188 +1,268 @@
-ifeq ($(CONFIG_OF),y)
-
-# Keep at91 dtb files sorted alphabetically for each SoC
-# rm9200
-dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
-# sam9260
-dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
-dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
-dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
-dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9260.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9260.dtb
-# sam9263
-dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9263.dtb
-# sam9g20
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
-dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
-# sam9g45
-dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
-# sam9n12
-dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
-# sam9x5
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g15ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
-
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
-dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb
-dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
-	da850-evm.dtb
-dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
-	dove-cubox.dtb \
-	dove-dove-db.dtb
-dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
-	exynos4210-smdkv310.dtb \
-	exynos4210-trats.dtb \
-	exynos4412-smdk4412.dtb \
-	exynos5250-smdk5250.dtb \
-	exynos5250-snow.dtb \
-	exynos5440-ssdk5440.dtb
-dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
-	ecx-2000.dtb
-dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
-	integratorcp.dtb
-dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
-dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
-	kirkwood-dns325.dtb \
-	kirkwood-dockstar.dtb \
-	kirkwood-dreamplug.dtb \
-	kirkwood-goflexnet.dtb \
-	kirkwood-guruplug-server-plus.dtb \
-	kirkwood-ib62x0.dtb \
-	kirkwood-iconnect.dtb \
-	kirkwood-iomega_ix2_200.dtb \
-	kirkwood-is2.dtb \
-	kirkwood-km_kirkwood.dtb \
-	kirkwood-lschlv2.dtb \
-	kirkwood-lsxhl.dtb \
-	kirkwood-mplcec4.dtb \
-	kirkwood-ns2.dtb \
-	kirkwood-ns2lite.dtb \
-	kirkwood-ns2max.dtb \
-	kirkwood-ns2mini.dtb \
-	kirkwood-nsa310.dtb \
-	kirkwood-topkick.dtb \
-	kirkwood-ts219-6281.dtb \
-	kirkwood-ts219-6282.dtb \
-	kirkwood-openblocks_a6.dtb
-dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
-dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
-	msm8960-cdp.dtb
-dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
-	armada-370-mirabox.dtb \
-	armada-370-rd.dtb \
-	armada-xp-db.dtb \
-	armada-xp-gp.dtb \
-	armada-xp-openblocks-ax3-4.dtb
-dtb-$(CONFIG_ARCH_MXC) += \
-	imx25-karo-tx25.dtb \
-	imx25-pdk.dtb \
-	imx27-apf27.dtb \
-	imx27-pdk.dtb \
-	imx31-bug.dtb \
-	imx51-apf51.dtb \
-	imx51-babbage.dtb \
-	imx53-ard.dtb \
-	imx53-evk.dtb \
-	imx53-mba53.dtb \
-	imx53-qsb.dtb \
-	imx53-smd.dtb \
-	imx6q-arm2.dtb \
-	imx6q-sabreauto.dtb \
-	imx6q-sabrelite.dtb \
-	imx6q-sabresd.dtb
-dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
-	imx23-olinuxino.dtb \
-	imx23-stmp378x_devb.dtb \
-	imx28-apf28.dtb \
-	imx28-apf28dev.dtb \
-	imx28-apx4devkit.dtb \
-	imx28-cfa10036.dtb \
-	imx28-cfa10037.dtb \
-	imx28-cfa10049.dtb \
-	imx28-evk.dtb \
-	imx28-m28evk.dtb \
-	imx28-sps1.dtb \
-	imx28-tx28.dtb
-dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb
-dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
-	omap3-beagle.dtb \
-	omap3-beagle-xm.dtb \
-	omap3-evm.dtb \
-	omap3-tobi.dtb \
-	omap4-panda.dtb \
-	omap4-panda-a4.dtb \
-	omap4-panda-es.dtb \
-	omap4-var-som.dtb \
-	omap4-sdp.dtb \
-	omap5-evm.dtb \
-	am335x-evm.dtb \
-	am335x-evmsk.dtb \
-	am335x-bone.dtb
-dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
-dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
-dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
-	hrefprev60.dtb \
-	hrefv60plus.dtb \
-	ccu9540.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
-	r8a7740-armadillo800eva.dtb \
-	sh73a0-kzm9g.dtb \
-	sh7372-mackerel.dtb
-dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
-	socfpga_vt.dtb
-dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
-	spear1340-evb.dtb
-dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
-	spear310-evb.dtb \
-	spear320-evb.dtb \
-	spear320-hmi.dtb
-dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
-dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb \
-	sun4i-a10-hackberry.dtb \
-	sun5i-a13-olinuxino.dtb
-dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
-	tegra20-iris-512.dtb \
-	tegra20-medcom-wide.dtb \
-	tegra20-paz00.dtb \
-	tegra20-plutux.dtb \
-	tegra20-seaboard.dtb \
-	tegra20-tec.dtb \
-	tegra20-trimslice.dtb \
-	tegra20-ventana.dtb \
-	tegra20-whistler.dtb \
-	tegra30-beaver.dtb \
-	tegra30-cardhu-a02.dtb \
-	tegra30-cardhu-a04.dtb \
-	tegra114-dalmore.dtb \
-	tegra114-pluto.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
-	vexpress-v2p-ca9.dtb \
-	vexpress-v2p-ca15-tc1.dtb \
-	vexpress-v2p-ca15_a7.dtb \
-	xenvm-4.2.dtb
-dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
-	wm8505-ref.dtb \
-	wm8650-mid.dtb \
-	wm8850-w70v2.dtb
-dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
-
-targets += dtbs
-targets += $(dtb-y)
-endif
-
-# *.dtb used to be generated in the directory above. Clean out the
-# old build results so people don't accidentally use them.
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	$(Q)rm -f $(obj)/../*.dtb
-
-clean-files := *.dtb
+ifeq ($(CONFIG_OF),y)
+
+# Keep dtb files sorted alphabetically for each ARCH/SoC
+
+# at91
+# rm9200
+dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
+# sam9260
+dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
+dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
+dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
+dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
+dtb-$(CONFIG_ARCH_AT91) += tny_a9260.dtb
+dtb-$(CONFIG_ARCH_AT91) += usb_a9260.dtb
+# sam9263
+dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
+dtb-$(CONFIG_ARCH_AT91) += usb_a9263.dtb
+# sam9g20
+dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
+dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
+dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
+dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
+# sam9g45
+dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
+# sam9n12
+dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
+# sam9x5
+dtb-$(CONFIG_ARCH_AT91) += at91sam9g15ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
+dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
+
+# bcm2835
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+
+# bcm
+dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb
+
+# davinci
+dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb
+dtb-$(CONFIG_ARCH_DAVINCI) += da850-evm.dtb
+
+# dove
+dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb
+dtb-$(CONFIG_ARCH_DOVE) += dove-cubox.dtb
+dtb-$(CONFIG_ARCH_DOVE) += dove-dove-db.dtb
+
+# exynos
+# exynos4210
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-smdkv310.dtb
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-trats.dtb
+# exynos4412
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos4412-smdk4412.dtb
+# exynos5250
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos5250-smdk5250.dtb
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos5250-snow.dtb
+# exynos5440
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos5440-ssdk5440.dtb
+
+# highbank
+dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
+dtb-$(CONFIG_ARCH_HIGHBANK) += ecx-2000.dtb
+
+# integrator
+dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb
+dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorcp.dtb
+
+# lpc32xxx
+dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
+
+# kirkwood
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns325.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dockstar.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dreamplug.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-goflexnet.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-guruplug-server-plus.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ib62x0.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-iconnect.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-iomega_ix2_200.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-is2.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-km_kirkwood.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-lschlv2.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-lsxhl.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-mplcec4.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ns2.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ns2lite.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ns2max.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ns2mini.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-nsa310.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-openblocks_a6.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-topkick.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ts219-6281.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-ts219-6282.dtb
+
+# marco
+dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+
+# msm
+dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb
+dtb-$(CONFIG_ARCH_MSM) += msm8960-cdp.dtb
+
+# mvebu
+# armada-370
+dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-370-mirabox.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-370-rd.dtb
+# armada-xp
+dtb-$(CONFIG_ARCH_MVEBU) += armada-xp-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-xp-gp.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-xp-openblocks-ax3-4.dtb
+
+# mxc
+# imx25
+dtb-$(CONFIG_ARCH_MXC) += imx25-karo-tx25.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx25-pdk.dtb
+# imx27
+dtb-$(CONFIG_ARCH_MXC) += imx27-apf27.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx27-pdk.dtb
+# imx31
+dtb-$(CONFIG_ARCH_MXC) += imx31-bug.dtb
+# imx51
+dtb-$(CONFIG_ARCH_MXC) += imx51-apf51.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb
+# imx53
+dtb-$(CONFIG_ARCH_MXC) += imx53-ard.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx53-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx53-mba53.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx53-qsb.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx53-smd.dtb
+# imx6q
+dtb-$(CONFIG_ARCH_MXC) += imx6q-arm2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx6q-sabreauto.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx6q-sabrelite.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx6q-sabresd.dtb
+
+# mxs
+# imx23
+dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx23-olinuxino.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx23-stmp378x_devb.dtb
+# imx28
+dtb-$(CONFIG_ARCH_MXS) += imx28-apf28.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-apf28dev.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-apx4devkit.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-cfa10036.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-cfa10037.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-cfa10049.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-evk.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-m28evk.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-sps1.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx28-tx28.dtb
+
+# nomdik
+dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb
+
+# omap2plus
+# am335x
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += am335x-bone.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += am335x-evm.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += am335x-evmsk.dtb
+# omap2
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb
+# omap3
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap3-beagle.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap3-beagle-xm.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap3-evm.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap3-tobi.dtb
+# omap4
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap4-panda.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap4-panda-a4.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap4-panda-es.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap4-sdp.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap4-var-som.dtb
+# omap5
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap5-evm.dtb
+
+# orion5x
+dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
+
+# prima2
+dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
+
+# u8500
+dtb-$(CONFIG_ARCH_U8500) += ccu9540.dtb
+dtb-$(CONFIG_ARCH_U8500) += hrefprev60.dtb
+dtb-$(CONFIG_ARCH_U8500) += hrefv60plus.dtb
+dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
+
+# shmobile
+dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE) += r8a7740-armadillo800eva.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE) += sh73a0-kzm9g.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE) += sh7372-mackerel.dtb
+
+# socfpga
+dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb
+dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_vt.dtb
+
+# spear3xx
+dtb-$(CONFIG_ARCH_SPEAR3XX) += spear300-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR3XX) += spear310-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR3XX) += spear320-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR3XX) += spear320-hmi.dtb
+
+# spear6xx
+dtb-$(CONFIG_ARCH_SPEAR6XX) += spear600-evb.dtb
+
+# spear13xx
+dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1340-evb.dtb
+
+# sunxi
+dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-cubieboard.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun4i-a10-hackberry.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun5i-a13-olinuxino.dtb
+
+# tegra
+# trega20
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-iris-512.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-medcom-wide.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-paz00.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-plutux.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-seaboard.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-tec.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-trimslice.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-ventana.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-whistler.dtb
+# trega30
+dtb-$(CONFIG_ARCH_TEGRA) += tegra30-beaver.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra30-cardhu-a02.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra30-cardhu-a04.dtb
+# trega114
+dtb-$(CONFIG_ARCH_TEGRA) += tegra114-dalmore.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra114-pluto.dtb
+
+# vexpress
+dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca9.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca15-tc1.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca15_a7.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += xenvm-4.2.dtb
+
+# vt8500
+dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb
+dtb-$(CONFIG_ARCH_VT8500) += wm8505-ref.dtb
+dtb-$(CONFIG_ARCH_VT8500) += wm8650-mid.dtb
+dtb-$(CONFIG_ARCH_VT8500) += wm8850-w70v2.dtb
+
+# zynq
+dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
+
+targets += dtbs
+targets += $(dtb-y)
+endif
+
+# *.dtb used to be generated in the directory above. Clean out the
+# old build results so people don't accidentally use them.
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	$(Q)rm -f $(obj)/../*.dtb
+
+clean-files := *.dtb
-- 
1.7.10.4
