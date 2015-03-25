From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 Mar 2015 11:14:28 +0100
Subject: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
In-Reply-To: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150325101428.GB32677@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc: += akpm]

On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K?nig wrote:
> on arm/i.MX28 the leds connected to a pwm are still broken and it's more
> than three years ago that I came up with these patches. I still consider
> them to do the right thing and they fix a real bug.
I'm really frustrated here. I want to fix a real bug, made several
suggestions (with patches) how to fix it and still have to include my
local patches in each project that uses leds on i.MX28's pwm output.

Thierry, how can we get this resolved?

Best regards
Uwe

> Old threads to this topic include:
> 
> 	http://thread.gmane.org/gmane.linux.kernel/1381289
> 	http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=282596
> 	http://thread.gmane.org/gmane.linux.pwm/1749
> 
> Uwe Kleine-K?nig (2):
>   pwm/doc: Clearify that the pin state after pwm_disable is undefined
>   leds/pwm: Don't disable pwm when setting brightness to 0
> 
>  Documentation/pwm.txt   |  5 +++++
>  drivers/leds/leds-pwm.c | 10 +++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
