From: acgzxing@gmail.com (Xing Zheng)
Date: Tue, 12 May 2015 17:26:37 +0800
Subject: [PATCH 4/4] ASoC: rockchip-audio-machine: add rockchip machine driver
 bindings
In-Reply-To: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1431422797-31903-5-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>

Add documentation to the machine driver of the device-tree
bindings for the soundcard of the Rockchip board.

Signed-off-by: zhengxing <zhengxing@rock-chips.com>

---

 .../sound/rockchip,rockchip-audio-machine.txt      |   38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-machine.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-machine.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-machine.txt
new file mode 100644
index 0000000..36864fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-machine.txt
@@ -0,0 +1,38 @@
+ROCKCHIP rk3288 audio complex, with AUDIO CODEC
+
+Required properties:
+- (machine) compatible : "rockchip,rockchip-audio-machine"
+- (codec) compatible : The child node name of compatible.
+- rockchip,model : The user-visible name of this sound complex.
+
+- rockchip,i2s-controller : The phandle of the Rockchip I2S controller that's
+  connected to the CODEC.
+- rockchip,audio-codec : The phandle of the audio codec.
+- rockchip,headset-codec : The phandle of the jack detection ic.
+
+Optional properties:
+- rockchip,hp-det-gpios : The GPIO that detect headphones are plugged in
+- rockchip,mic-det-gpios : The GPIO that detect microphones are plugged in
+
+Example:
+
+sound {
+	compatible = "rockchip,rockchip-audio-machine";
+
+	/* child node */
+	sound_rtl {
+		compatible = "rockchip,rockchip-audio-rt5645";
+		rockchip,model = "I2S-RT5650";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&rt5645>;
+	};
+
+	/* child node */
+	sound_maxim {
+		compatible = "rockchip,rockchip-audio-max98090";
+		rockchip,model = "ROCKCHIP-I2S";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&max98090>;
+		rockchip,headset-codec = <&headsetcodec>;
+	};
+};
\ No newline at end of file
-- 
1.7.9.5
