From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 21:32:06 +0200
Subject: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
Message-ID: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to atomic PWM. The main goal is to properly wait for a period before
disabling a channel to ensure the correct level is set on the output.

Changes in v2:
 - fixed remaining checkpatch warnings
 - split the series to ease reviews
 - changed the delay handling to ensure the proper amount of time has elapsed
   before disabling a channel
 - dropped RDY bit handling as it doesn't have any real effect.

Alexandre Belloni (3):
  pwm: sun4i: improve hardware read out
  pwm: sun4i: switch to atomic PWM
  pwm: sun4i: drop legacy callbacks

 drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------------
 1 file changed, 148 insertions(+), 115 deletions(-)

-- 
2.11.0
