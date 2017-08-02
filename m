From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:56:18 +0800
Subject: [PATCH v2 21/23] ARM: dts: rockchip: add pwm backlight for rv1108 evb
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501664178-12881-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RV1108 EVB uses pwm0 modulate the backlight, add dt
node to enable it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108-evb.dts | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 44feea7..77ce707 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -55,6 +55,49 @@
 		stdout-path = "serial2:1500000n8";
 		bootargs = "root=/dev/mtdblock2 mtdparts=spi-nor:256k at 0(u-boot)ro,6m(kernel)ro,9m(rootfs),-(freedisk)";
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 25000 0>;
+		brightness-levels = <
+			  0   1   2   3   4   5   6   7
+			  8   9  10  11  12  13  14  15
+			 16  17  18  19  20  21  22  23
+			 24  25  26  27  28  29  30  31
+			 32  33  34  35  36  37  38  39
+			 40  41  42  43  44  45  46  47
+			 48  49  50  51  52  53  54  55
+			 56  57  58  59  60  61  62  63
+			 64  65  66  67  68  69  70  71
+			 72  73  74  75  76  77  78  79
+			 80  81  82  83  84  85  86  87
+			 88  89  90  91  92  93  94  95
+			 96  97  98  99 100 101 102 103
+			104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119
+			120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135
+			136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151
+			152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167
+			168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183
+			184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199
+			200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215
+			216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231
+			232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247
+			248 249 250 251 252 253 254 255>;
+		default-brightness-level = <200>;
+	};
+};
+
+&pwm0 {
+	status = "okay";
 };
 
 &sdmmc {
-- 
2.7.4
