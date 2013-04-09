From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 22:31:18 +0200
Subject: [GIT PULL 04/10] clk-exynos for v3.10
In-Reply-To: <51630A02.4080905@samsung.com>
References: <51630A02.4080905@samsung.com>
Message-ID: <201304092231.18314.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Kukjin Kim wrote:
> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> 
>    Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/clk-exynos-for-v3.10
> 
> for you to fetch changes up to da821eb7d42935b0f7056d98c75fd1150f6636f4:
> 
>    Merge commit 'v3.9-rc5' into next/clk-exynos (2013-04-09 01:10:13 +0900)
> 
> ----------------------------------------------------------------
> 
> add suppport common clock framework for exynos

I got a build warning, probably because of this patch:

>       ARM: dts: Add MSHC node for exynos4412-origen DT

Fixed up as below, please check.

Pulled into the next/drivers tree.

	Arnd

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 15dc0a3..53bc8bf 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -39,6 +39,8 @@
        };
 
        mshc at 12550000 {
+               #address-cells = <1>;
+               #size-cells = <0>;
                pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
                pinctrl-names = "default";
                status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index a5478bd..1fecf76 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -45,6 +45,8 @@
        };
 
        mshc at 12550000 {
+               #address-cells = <1>;
+               #size-cells = <0>;
                pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
                pinctrl-names = "default";
                status = "okay";
