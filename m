From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Wed, 29 Jun 2011 21:47:22 +0200
Subject: [PATCH 1/2] PWM: add pwm framework support
In-Reply-To: <1309338215-10702-2-git-send-email-s.hauer@pengutronix.de>
References: <1309338215-10702-1-git-send-email-s.hauer@pengutronix.de>
	<1309338215-10702-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110629194722.GA10861@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Wed, Jun 29, 2011 at 11:03:34AM +0200 Sascha Hauer ha dit:

> This patch adds framework support for PWM (pulse width modulation) devices.
> 
> The is a barebone PWM API already in the kernel under include/linux/pwm.h,
> but it does not allow for multiple drivers as each of them implements the
> pwm_*() functions.
> 
> There are other PWM framework patches around from Bill Gatliff. Unlike
> his framework this one does not change the existing API for PWMs so that
> this framework can act as a drop in replacement for the existing API.
> 
> Why another framework?
> 
> Several people argue that there should not be another framework for PWMs
> but they should be integrated into one of the existing frameworks like led
> or hwmon. Unlike these frameworks the PWM framework is agnostic to the
> purpose of the PWM. In fact, a PWM can drive a LED, but this makes the
> LED framework a user of a PWM, like already done in leds-pwm.c. The gpio
> framework also is not suitable for PWMs. Every gpio could be turned into
> a PWM using timer based toggling, but on the other hand not every PWM hardware
> device can be turned into a gpio due to the lack of hardware capabilities.
> 
> This patch does not try to improve the PWM API yet, this could be done in
> subsequent patches.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Matthias Kaehlcke <matthias@kaehlcke.net>

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

            You must have long-range goals to keep you from
                being frustrated by short-range failure
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
