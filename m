From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 20 Nov 2012 06:44:44 +1300
Subject: [PATCH v3 0/2] pwm fixes for 3.8
Message-ID: <1353347086-4572-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Theirry,

I felt the error message for clk_enable in vt8500_pwm_config() needed
to somehow indicate that the clk_enable failed in this function otherwise
if there is a problem, you can't tell which of the clk_enable's
generated the fail message.
If there is a clock error - as you pointed out - it will probably fail
elsewhere as well so I've changed it to match the other error messages.

These should be applied on top of the original patch.

v2: Add error checking for clk_enable()
v3: Remove superfluous ;'s. Error message style correction.

Tony Prisk (2):
  Fix build error in pwm-vt8500.c
  pwm: vt8500: Ensure pwm clock is enabled during pwm_config

 drivers/pwm/pwm-vt8500.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
1.7.9.5
