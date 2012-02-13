From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 10:48:02 -0600
Subject: [PATCH] ep93xx: fix build of vision_ep93xx.c
In-Reply-To: <201202130658.12505.arnd@arndb.de>
References: <201202080953.44853.hartleys@visionengravers.com>
 <20120210064640.GA3847@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F001F41F9DF77C@AUSP01VMBX24.collaborationhost.net>
 <201202130658.12505.arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4CD8@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, February 12, 2012 11:58 PM, Arnd Bergmann wrote:
> On Friday 10 February 2012, H Hartley Sweeten wrote:
>> On Thursday, February 09, 2012 11:47 PM, Mika Westerberg wrote:
>>> On Wed, Feb 08, 2012 at 09:53:44AM -0700, H Hartley Sweeten wrote:
>>>> Fix build breakage due to the following commits:
>>>> 
>>>> Commit bd5f12a24766c1f299def0a78b008d4746f528f2
>>>>   ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics
>>>> 
>>>> Commit 257af9f9725aa8a863b306659208a031135d59e7
>>>>   ARM: 7041/1: gpio-ep93xx: hookup the to_irq callback in the driver
>>>> 
>>>> The vision_ep9307 machine uses the ep93xx build-in gpios and needs to
>>>> include <mach/gpio-ep93xx.h> to pickup the defines.
>>>> 
>>>> The gpio_to_irq() call is now a callback to the gpio-ep93xx.c driver
>>>> and cannot be used as a constant initializer for the .irq member of
>>>> struct i2c_board_info.
>>>> 
>>>> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
>>>> Acked-by: Ryan Mallon <rmallon@gmail.com>
>>>
>>> Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
>> 
>> Russell,
>> 
>> Can this go to your Patch system or should it go thru the arm-soc tree?
>> 
>> The 3.2 kernel will not currently build with CONFIG_MACH_VISION_EP9307=y
>> and needs this patch.
>
> Hi Hartley, Ryan and Mika,
>
> It should indeed go through the arm-soc tree, I'm sorry for having
> been so unresponsive recently. Olof was taking care of the other
> pull requests and bug fixes but unfortunately was not on Cc on this
> one, so we both ended up missing it until now.
>
> I've applied it on the "fixes" branch of the arm-soc tree now, it
> will get sent to Linus on the next opportunity.

Thanks!

>I had a little trouble applying the patch from base64 format, but
>since you've had to wait so long already and I'm not completely sure
>which side the problem was on I took the time to recreate the diff
>from the base64 encoding and fix up the whitespace damage I got.

Hmm... I'm not sure what caused the base64 encoding. I recently
updated my host machine but I don't think anything I did would have
caused the mail to be encoded differently.

I'll look into it and try to find the problem.

Thanks,
Hartley
