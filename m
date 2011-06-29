From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2011 13:00:28 +0200
Subject: [PATCH 1/2] PWM: add pwm framework support
In-Reply-To: <20110629085046.GM6069@pengutronix.de>
References: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
	<201106281903.06121.arnd@arndb.de>
	<20110629085046.GM6069@pengutronix.de>
Message-ID: <201106291300.28533.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 June 2011, Sascha Hauer wrote:
> The other type is some mfd drivers which implement the pwm API themselves
> right now. These are currently incompatible with the pwm framework anyway.
> If a board wants to connect the mfd pwm to its backlight, the current
> pwm_request based on an integer id is not suitable anymore. We need
> a (struct device *dev, char *id) based pwm_request function then.
> So my plan is to change the pwm API once we have all in tree drivers
> in drivers/pwm.

Ok, sounds good. I don't much like the idea of using a string identifier
for this, but let's discuss that when we get there. Using fixed numbers
for the first version seems totally reasonable, as it keeps the existing
API.

	Arnd
