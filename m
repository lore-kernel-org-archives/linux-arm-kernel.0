From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:25 -0800
Subject: [PATCH 1/9] arm64: dts: Add symlinks for cros-ec-keyboard and
 cros-ec-sbs
In-Reply-To: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
Message-ID: <1480645653-36943-2-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Douglas Anderson <dianders@chromium.org>

We'd like to be able to use the cros-ec-keyboard.dtsi and
cros-ec-sbs.dtsi snippets for arm64 devices.  Currently those files live
in the arm/boot/dts directory.

Let's follow the convention set by commit 8ee57b8182c4 ("ARM64: dts:
vexpress: Use a symlink to vexpress-v2m-rs1.dtsi from arch=arm") and use
a symlink.  Note that in this case we put the files in a new
"include/common" directory since these snippets may need to be
referenced by dts files in many different subdirectories.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Heiko Stueber <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
This was submitted months ago but had no users

 arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi | 1 +
 arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi      | 1 +
 2 files changed, 2 insertions(+)
 create mode 120000 arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi
 create mode 120000 arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi

diff --git a/arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi b/arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi
new file mode 120000
index 000000000000..1c1889f0a791
--- /dev/null
+++ b/arch/arm64/boot/dts/include/common/cros-ec-keyboard.dtsi
@@ -0,0 +1 @@
+../../../../../arm/boot/dts/cros-ec-keyboard.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi b/arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi
new file mode 120000
index 000000000000..3d7ae9c88bcd
--- /dev/null
+++ b/arch/arm64/boot/dts/include/common/cros-ec-sbs.dtsi
@@ -0,0 +1 @@
+../../../../../arm/boot/dts/cros-ec-sbs.dtsi
\ No newline at end of file
-- 
2.8.0.rc3.226.g39d4020
