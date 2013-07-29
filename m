From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 11:33:58 -0600
Subject: Board-specific GPIO setup code
In-Reply-To: <CAOMZO5DCPvKVJNVp9cZMiMvY3bxhXdjmJs+dqNXdhxDDoSLQmQ@mail.gmail.com>
References: <51F568AD.8030001@prisktech.co.nz> <51F69D2B.6030605@wwwdotorg.org>
 <CAOMZO5DCPvKVJNVp9cZMiMvY3bxhXdjmJs+dqNXdhxDDoSLQmQ@mail.gmail.com>
Message-ID: <51F6A786.4080709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 11:21 AM, Fabio Estevam wrote:
> On Mon, Jul 29, 2013 at 1:49 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 07/28/2013 12:53 PM, Tony Prisk wrote:
>>> On the Wandboard (IMX6Q SoC), there is a WiFi module connected via SDIO
>>> that requires a reset procedure to enable it. This would be board
>>> specific setup, but gpio_* functions can't be used in
>>> arch/arm/mach-imx/imx6q.c
>>>
>>> What would be the correct place to perform the reset code (basically a
>>> series of gpio calls) to reset the WiFi controller or should it be done
>>> earlier in uboot?
>>
>> The correct approach is probably to enhance the SDIO controller (or SDIO
>> core) to know how to power/reset/... the device that's attached to it.
> 
> Can't we just use the gpio reset driver proposed by Philipp Zabel?
> http://www.spinics.net/lists/arm-kernel/msg261771.html

Quite possibly, but the SD binding and driver still would need to be
updated to actually invoke it.

Also, that only covers reset, not any enable GPIO, 32KHz clock,
regulator, etc.
