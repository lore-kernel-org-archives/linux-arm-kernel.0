From: Claudiu.Beznea@microchip.com (m18063)
Date: Mon, 27 Mar 2017 17:05:58 +0300
Subject: [PATCH v3 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
In-Reply-To: <20170327131530.ifexyrgrp5egtbtr@piout.net>
References: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
 <1490189375-20384-2-git-send-email-claudiu.beznea@microchip.com>
 <20170327150237.69d8523f@bbrezillon>
 <20170327131530.ifexyrgrp5egtbtr@piout.net>
Message-ID: <08b1036a-bb4d-5ae2-1a68-68ccdc0b3fef@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27.03.2017 16:15, Alexandre Belloni wrote:
> On 27/03/2017 at 15:02:37 +0200, Boris Brezillon wrote:
>> Hi Claudiu,
>>
>> On Wed, 22 Mar 2017 15:29:34 +0200
>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>>
>>>  static const struct platform_device_id atmel_pwm_devtypes[] = {
>>>  	{
>>>  		.name = "at91sam9rl-pwm",
>>> -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v1,
>>> +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v1,
>>>  	}, {
>>>  		.name = "sama5d3-pwm",
>>> -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v2,
>>> +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v2,
>>>  	}, {
>>>  		/* sentinel */
>>>  	},
>> Unrelated to this series, but can you prepare a patch to get rid of
>> this platform id table (AT91 platforms have completely switched to DT
>> for quite some time now).
>>
> Please, don't until AVR32 is gone.

Sure, I will wait for it.

>
>> You can also get rid of the "if (pdev->dev.of_node)" condition in
>> atmel_pwm_probe() since it's guaranteed to be true, otherwise the
>> ->probe() method wouldn't be called.
>>
>> Thanks,
>>
>> Boris
