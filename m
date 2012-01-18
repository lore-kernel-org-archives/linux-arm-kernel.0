From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 18 Jan 2012 17:20:39 -0600
Subject: [PATCH] ep93xx: fix build of vision_ep93xx.c
In-Reply-To: <4F173CCB.2050009@gmail.com>
References: <201201161305.23508.hartleys@visionengravers.com>
 <4F173CCB.2050009@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EC642@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 18, 2012 2:43 PM, Ryan Mallon wrote:
> On 17/01/12 07:05, H Hartley Sweeten wrote:
>> Fix build breakage due to the following commits:
>> 
>> Commit bd5f12a24766c1f299def0a78b008d4746f528f2
>>   ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics
>> 
>> Commit 257af9f9725aa8a863b306659208a031135d59e7
>>   ARM: 7041/1: gpio-ep93xx: hookup the to_irq callback in the driver
>> 
>> The vision_ep9307 machine uses the ep93xx build-in gpios and needs to 
>> include <mach/gpio-ep93xx.h> to pickup the defines.
>> 
>> The gpio_to_irq() call is now a callback to the gpio-ep93xx.c driver 
>> and cannot be used as a constant initializer for the .irq member of 
>> struct i2c_board_info.
>> 
>> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>
>
> Hi Hartley,
> 
> Sorry for the delay. This looks correct to me.
> 
> Acked-by: Ryan Mallon <rmallon@gmail.com>

Thanks.

Should this go through Russell's patch system or the arm-soc tree?
If it's the arm-soc tree do you know to get a patch to them?

Regards,
Hartley
