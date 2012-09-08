From: simon@fire.lp0.eu (Simon Arlott)
Date: Sat, 08 Sep 2012 13:37:01 +0100
Subject: [PATCH V2] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <1347083284-17799-1-git-send-email-swarren@wwwdotorg.org>
References: <1347083284-17799-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504B3BED.9080204@simon.arlott.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/12 06:48, Stephen Warren wrote:
> +void __init bcm2708_init_irq(void)
> +{
> +}
...
> +static void __init bcm2708_timer_init(void)
> +{
> +}

There's no timer and no interrupt handler so it won't even finish
booting. It's going to stall when it tries to calculate loops per jiffy.

I don't know what you're trying to achieve. This does not add support
for the BCM2708.

See https://github.com/lp0/linux/commits/rpi-split from June 21 onwards
for separate patch commits that apply to specific devices.


On 08/09/12 06:48, Stephen Warren wrote:
> v2:
> * Rename *_BASE to *_PHYS to match Simon's rpi-split branch.

You've definitely used the rpi-linear branch if you're missing things.
The HEAD of the two branches is identical but rpi-split has a rebased
history.

-- 
Simon Arlott
