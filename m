From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 18:02:02 +0800
Subject: [PATCH 5/6] arm: footbridge: convert old leds event driver to led
	gpio trigger driver of Netwinder
In-Reply-To: <20110613082301.GB9393@n2100.arm.linux.org.uk>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
	<1307947185-5159-6-git-send-email-bryan.wu@canonical.com>
	<20110613082301.GB9393@n2100.arm.linux.org.uk>
Message-ID: <BANLkTim-Vbe+rp-aJaXuy8ja4UKDsV8MGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 4:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 13, 2011 at 02:39:44PM +0800, Bryan Wu wrote:
>> +/* LEDs */
>> +static struct gpio_led nw_gpio_leds[] = {
>> + ? ? ? ?{
>> + ? ? ? ? ? ? ? ?.name ? ? ? ? ? ? ? ? ? = "netwinder::led_red",
>> + ? ? ? ? ? ? ? ?.default_trigger ? ? ? ?= "heartbeat",
>> + ? ? ? ? ? ? ? ?.gpio ? ? ? ? ? ? ? ? ? = GPIO_RED_LED,
>> + ? ? ? ?},
>> + ? ? ? ?{
>> + ? ? ? ? ? ? ? ?.name ? ? ? ? ? ? ? ? ? = "netwinder::led_green",
>> + ? ? ? ? ? ? ? ?.default_trigger ? ? ? ?= "timer",
>> + ? ? ? ? ? ? ? ?.gpio ? ? ? ? ? ? ? ? ? = GPIO_GREEN_LED,
>> + ? ? ? ?},
>
> This is especially broken. ?This platform has no GPIO support other
> than its private stuff, which makes the use of the GPIO LED driver
> useless. ?The GPIO_*_LED constants are bitmasks for the CPLD
> controller.
>

I was totally confused by the name GPIO_*_* definitions stuff in the
hardware.h. Sorry about that, it looks like I need rewrite it as my
6th patch.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
