From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 25 Nov 2013 21:43:42 +0100
Subject: [PATCH 0/3] leds/pwm: don't call pwm_disable when setting brightness
Message-ID: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

some time ago I pointed out a problem with leds-pwm on i.MX28, because
on this SoC it can happen that after:

	pwm_config(pwm, 0, period);
	pwm_disable(pwm);

the connected LED stays on. The mail thread is available at

	http://thread.gmane.org/gmane.linux.kernel/1381289

This series implements the outcome that didn't get any opposition, i.e.
the pin state is explicitly undefined after pwm_disable. The first patch
adds this fact to the general pwm docs, the second patch fixes the
leds-pwm driver accordingly. The third patch is just a trivial fix that
I noticed while patching the leds-pwm driver and not really related to
any problem.

Best regards
Uwe

Uwe Kleine-K?nig (3):
  pwm/doc: Clearify that the pin state after pwm_disable is undefined
  leds/pwm: Don't disable pwm when setting brightness to 0
  leds/pwm: fix driver description and make license match the header

 Documentation/pwm.txt   |  5 +++++
 drivers/leds/leds-pwm.c | 14 +++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
1.8.4.2
