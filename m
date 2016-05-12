From: dianders@chromium.org (Douglas Anderson)
Date: Thu, 12 May 2016 15:02:10 -0700
Subject: [PATCH] arm64: dts: Add symlinks for cros-ec-keyboard and cros-ec-sbs
Message-ID: <1463090530-21864-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to be able to use the cros-ec-keyboard.dtsi and
cros-ec-sbs.dtsi snippets for arm64 devices.  Currently those files live
in the arm/boot/dts directory.

Let's follow the convention set by commit 8ee57b8182c4 ("ARM64: dts:
vexpress: Use a symlink to vexpress-v2m-rs1.dtsi from arch=arm") and use
a symlink.  Note that in this case we put the files in a new
"include/common" directory since these snippets may need to be
referenced by dts files in many different subdirectories.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note that, as of right now, there are no users of this.  However, given
development happening it is almost 100% certain that users will arrive
soon.  If we need to wait for the first user before landing this we can
leave this on the back burner.  If it's OK to have no users (yet), let's
land.

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
