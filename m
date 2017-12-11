From: javierm@redhat.com (Javier Martinez Canillas)
Date: Mon, 11 Dec 2017 23:48:56 +0100
Subject: [RFT PATCH] ARM: dts: exynos: Enable Mixer node for Exynos5800 Peach
 Pi machine
Message-ID: <20171211224856.29264-1-javierm@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x
Mixer nodes") disabled the Mixer node by default in the DTSI and enabled
for each Exynos 542x DTS. But unfortunately it missed to enable it for the
Exynos5800 Peach Pi machine, since the 5800 is also an 542x SoC variant.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

I believe this may cause the boot issues reported on Exynos5800 Peach Pi
from v4.15-rc3, the mentioned commit made to v4.15-rc1 but it seems that
didn't cause any harm until commit ("510353a63796 drm/bridge: analogix
dp: Fix runtime PM state in get_modes() callback") fixed the runtime PM
management in the DP driver.

I can't test right now, but I'm posting anyways as a RFT in case others
that have access to a Peach Pi can test it.

Best regards,
Javier

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
