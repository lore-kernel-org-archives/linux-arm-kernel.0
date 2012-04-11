From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 11 Apr 2012 18:07:41 -0500
Subject: [PATCH v2] arm: ep93xx: use gpio_led_register_device
In-Reply-To: <4F85FFB6.8050406@gmail.com>
References: <201204111429.20038.hartleys@visionengravers.com>
 <4F85FFB6.8050406@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206986C0701@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 11, 2012 3:04 PM, Ryan Mallon wrote:
> On 12/04/12 07:29, H Hartley Sweeten wrote:
>>  menu "Cirrus EP93xx Implementation Options"
>>  
>> +config ARCH_EP93XX_TYPICAL
>
>
> One minor change. Please use a different name for this. Since all
> of the boards use this and it cannot be unselected, its a bit
> misleading to call it typical. EP93XX_SOC or EP93XX_COMMON would
> be a bit better.

Done.  Changed it to EP93XX_SOC_COMMON

>> +	bool
>> +	default y

I guess this could also be

	def_bool y

But, I don't know if it's necessary...

>> +	select LEDS_GPIO_REGISTER
>> +

Hartley
