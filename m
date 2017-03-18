From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 18 Mar 2017 13:27:34 +0100
Subject: [PATCH v2 0/2] meson-gxl pinctrl - add the missing PWM pins
In-Reply-To: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170318122736.11592-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the lack of a public GXL or GXM datasheet most of the PWM pin
definitions are currently missing.
However, the people behind the Khadas VIM boards were kind enough to
share the PWM pins and their corresponding register offsets and bits
with me.

This patch adds all missing PWM pins to the GXL pinctrl driver. The
upcoming Khadas VIM board support patch only needs PWM_F and PWM_AO_A.
I still decided to add all PWM pins just in case there's no public GXL
datasheet release soon.


Changes since v1:
- combined previously separate functions for example: there were
  separate functions pwm_ao_a_3 and pwm_ao_a_8) into one function
  (in the previous example: pwm_ao_a). this affects both, the dtsi
  and driver patches and was done for pwm_ao_a and pwm_f.
  this is the result of a discussion [0] based on v1 of these patches
  along with re-reading Linus Walleij's pinctrl documentation [1]
- added Neil Armstrong's Reviewed-By and Tested-By


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/002864.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/002816.html

Martin Blumenstingl (2):
  pinctrl: meson: gxl: add the missing PWM pin definitions
  ARM64: dts: amlogic: meson-gxl: add the missing PWM pins

 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 56 ++++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 54 ++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

-- 
2.12.0
