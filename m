From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jul 2013 14:21:05 -0300
Subject: Board-specific GPIO setup code
In-Reply-To: <51F69D2B.6030605@wwwdotorg.org>
References: <51F568AD.8030001@prisktech.co.nz> <51F69D2B.6030605@wwwdotorg.org>
Message-ID: <CAOMZO5DCPvKVJNVp9cZMiMvY3bxhXdjmJs+dqNXdhxDDoSLQmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 1:49 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/28/2013 12:53 PM, Tony Prisk wrote:
>> On the Wandboard (IMX6Q SoC), there is a WiFi module connected via SDIO
>> that requires a reset procedure to enable it. This would be board
>> specific setup, but gpio_* functions can't be used in
>> arch/arm/mach-imx/imx6q.c
>>
>> What would be the correct place to perform the reset code (basically a
>> series of gpio calls) to reset the WiFi controller or should it be done
>> earlier in uboot?
>
> The correct approach is probably to enhance the SDIO controller (or SDIO
> core) to know how to power/reset/... the device that's attached to it.

Can't we just use the gpio reset driver proposed by Philipp Zabel?
http://www.spinics.net/lists/arm-kernel/msg261771.html

Regards,

Fabio Estevam
