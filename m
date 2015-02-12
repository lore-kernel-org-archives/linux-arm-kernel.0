From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 10:44:48 +0100
Subject: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting brightness
Message-ID: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

on arm/i.MX28 the leds connected to a pwm are still broken and it's more
than three years ago that I came up with these patches. I still consider
them to do the right thing and they fix a real bug.

Old threads to this topic include:

	http://thread.gmane.org/gmane.linux.kernel/1381289
	http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=282596
	http://thread.gmane.org/gmane.linux.pwm/1749

Uwe Kleine-K?nig (2):
  pwm/doc: Clearify that the pin state after pwm_disable is undefined
  leds/pwm: Don't disable pwm when setting brightness to 0

 Documentation/pwm.txt   |  5 +++++
 drivers/leds/leds-pwm.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.1.4
