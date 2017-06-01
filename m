From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu,  1 Jun 2017 14:18:24 +0200
Subject: [PATCHv2 0/2] gpio: mvebu: fixes for PWM/blink
Message-ID: <20170601121826.14685-1-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are 2 fixes for gpio-mvebu, related to the PWM support introduced
by commit 757642f9a584 ("gpio: mvebu: Add limited PWM support")
As that commit was merged in 4.12-rc1, I guess these commits are 4.12
material.

Changes from v1:
 - Add tags Fixes: and Reviewed-by:
 - Add some comments to motivate the mvpwm->chip->base = -1 choice
instead of mvpwm->chip->base = mvchip->chip.base

Richard Genoud (2):
  gpio: mvebu: fix blink counter register selection
  gpio: mvebu: fix gpio bank registration when pwm is used

 drivers/gpio/gpio-mvebu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
