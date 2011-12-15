From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 15 Dec 2011 09:22:11 -0500 (EST)
Subject: label string for kirkwood gpiochip
In-Reply-To: <4EE9FC0D.10009@keymile.com>
References: <4EE9FC0D.10009@keymile.com>
Message-ID: <alpine.LFD.2.02.1112150920430.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Dec 2011, Holger Brunck wrote:

> Hi,
> we recently switched with our kirkwood based board to a newer kernel version.
> Our application code is written in that way if someone request an gpio in
> userspace that he do search the gpiochip via the gpio label.
> 
> The newer kernel version handles the gpiochip on kirkwood in a different way.
> The orion_gpio_init function in arch/arm/mach-kirkwood/irq.c was called twice.
> Once for first 32 gpios and a second time for the remaining 18 gpios. This
> causes that the gpio framework shows two gpiochips in the sysfs with the same
> label (orion_gpio).
> 
> [@km_kirkwood /]# cat /sys/class/gpio/gpiochip0/label
> orion_gpio
> [@km_kirkwood /]# cat /sys/class/gpio/gpiochip32/label
> orion_gpio
> 
> So my question is simply, shouldn't be the string for a gpiochip unique in the
> system and therefore this should be fixed or was this intended?

I don't think that was intended.


Nicolas
