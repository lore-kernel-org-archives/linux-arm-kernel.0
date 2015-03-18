From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Mar 2015 10:51:33 +0000
Subject: [PATCH 0/6] pinctrl: st: Fix disparity between Pinctrl & GPIO in
 /sysfs
Message-ID: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's hardware differentiates between GPIO mode and Pinctrl alternate
functions.  When a pin is in GPIO mode, there are dedicated registers
to set and obtain direction status.  However, If a pin's alternate
function is in use then the direction is set and status is derived
from a bunch of syscon registers.  The issue is; until now there was
a lack of parity between the two.

Further explanation with examples can be found in the commit logs.

Karim BEN BELGACEM (1):
  ARM: STi: DT: STiH407: Fix retime pin mask for PIO5 and PIO35

Lee Jones (5):
  pinctrl: st: Introduce a 'get pin function' call
  pinctrl: st: Move st_get_pio_control() further up the source file
  pinctrl: st: Supply a GPIO get_direction() call-back
  pinctrl: st: Show correct pin direction -- even when in GPIO mode
  pinctrl: st: Display pin's function when printing pinctrl debug
    information

 arch/arm/boot/dts/stih407-pinctrl.dtsi |  2 +
 drivers/pinctrl/pinctrl-st.c           | 83 +++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 12 deletions(-)

-- 
1.9.1
