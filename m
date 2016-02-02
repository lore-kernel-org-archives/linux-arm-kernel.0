From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  2 Feb 2016 11:40:52 +0800
Subject: [PATCH v5 4/8] ARM: dts: rockchip: add mclk for rt5616 on kylin board
In-Reply-To: <1454384453-7127-1-git-send-email-wxt@rock-chips.com>
References: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
 <1454384453-7127-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1454384453-7127-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2S block that provide the output clock as the mclk for rt5616,
That will be the master clock  input.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v5: None
Changes in v4:
- AS the previous discussed by them, add the mclk for codec.
 (https://patchwork.kernel.org/patch/8041001/)

 arch/arm/boot/dts/rk3036-kylin.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index cd45434..b0473bc 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -328,6 +328,8 @@
 	rt5616: rt5616 at 1b {
 		compatible = "rt5616";
 		reg = <0x1b>;
+		clocks = <&cru SCLK_I2S_OUT>;
+		clock-names = "mclk";
 		#sound-dai-cells = <0>;
 	};
 };
-- 
1.9.1
