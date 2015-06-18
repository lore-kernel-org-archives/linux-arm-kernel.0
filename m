From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jun 2015 20:08:31 -0600
Subject: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
In-Reply-To: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
References: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
Message-ID: <5582281F.8060402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2015 08:04 AM, Noralf Tr?nnes wrote:
> Currently poweroff/halt results in a reboot on the Raspberry Pi.
> The firmware uses the RSTS register to know which partiton to
> boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
> 
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh

Tested-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I wonder if, sometime down the road, it's worth querying the firmware
version via the firmware driver and dynamically doing the right thing.
Still, the combination of a bleeding edge kernel and an ancient firmware
seems a bit unlikely, so perhaps not worth the bother.
