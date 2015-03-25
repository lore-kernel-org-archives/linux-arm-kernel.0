From: olivier.clergeaud@st.com (Olivier CLERGEAUD)
Date: Wed, 25 Mar 2015 14:06:44 +0000
Subject: [PATCH v2 0/6] pinctrl: st: Fix disparity between Pinctrl &
 GPIO in /sysfs
In-Reply-To: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
References: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
Message-ID: <9D46209077AA0C4A98CD781BE48184B81EAC58@SAFEX1NODE23.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the series:

Acked-by: Olivier Clergeaud <Olivier.clergeaud@st.com>

-----Original Message-----
From: Lee Jones [mailto:lee.jones at linaro.org] 
Sent: mercredi 18 mars 2015 18:21
To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linus.walleij at linaro.org; linux-gpio at vger.kernel.org
Cc: lee.jones at linaro.org; kernel at stlinux.com
Subject: [PATCH v2 0/6] pinctrl: st: Fix disparity between Pinctrl & GPIO in /sysfs

Version 2:
  Fixed up Maxime's review comments
    - Reduce size of char array
    - Use snprintf()
  Applied Maxime's Acks 

ST's hardware differentiates between GPIO mode and Pinctrl alternate functions.  When a pin is in GPIO mode, there are dedicated registers to set and obtain direction status.  However, If a pin's alternate function is in use then the direction is set and status is derived from a bunch of syscon registers.  The issue is; until now there was a lack of parity between the two.

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
