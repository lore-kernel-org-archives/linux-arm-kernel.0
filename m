From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 17:02:22 +0800
Subject: [PATCH 0/3] ARM: imx: pllv3 relock fixes
Message-ID: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series includes a couple of pllv3 relock updates which should fix
IPU clocking problem found in HDMI testing.

Russell,

I did not add BYPASS handling in .set_rate() operation in this series,
because so far it's unclear to me if it solves any problem for us.  We
can add it later if we confirm it does help.

Shawn

Shawn Guo (3):
  ARM: imx: add sleep for pllv3 relock
  ARM: imx: pllv3 needs relock in .set_rate() call
  ARM: imx: set up pllv3 POWER and BYPASS sequentially

 arch/arm/mach-imx/clk-pllv3.c |   51 +++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
1.7.9.5
