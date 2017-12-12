From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 12 Dec 2017 08:42:08 +0100
Subject: [PATCH v2] ARM: dts: exynos: Enable Mixer node for Exynos5800 Peach
 Pi machine
Message-ID: <20171212074208.30753-1-javierm@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x
Mixer nodes") disabled the Mixer node by default in the DTSI and enabled
for each Exynos 542x DTS. But unfortunately it missed to enable it for the
Exynos5800 Peach Pi machine, since the 5800 is also an 542x SoC variant.

Fixes: 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x Mixer nodes")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

---

Changes in v2:
- Remove RFT tag.
- Add Marek's Acked-by tag.
- Add fixes tag.

 arch/arm/boot/dts/exynos5800-peach-pi.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index b2b95ff205e8..0029ec27819c 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -664,6 +664,10 @@
 	status = "okay";
 };
 
+&mixer {
+	status = "okay";
+};
+
 /* eMMC flash */
 &mmc_0 {
 	status = "okay";
-- 
2.14.3
