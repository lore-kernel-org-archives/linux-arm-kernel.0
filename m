From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 10 Feb 2012 10:40:15 -0600
Subject: [PATCH] ep93xx: fix build of vision_ep93xx.c
In-Reply-To: <20120210064640.GA3847@mwesterb-mobl.ger.corp.intel.com>
References: <201202080953.44853.hartleys@visionengravers.com>
 <20120210064640.GA3847@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41F9DF77C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 09, 2012 11:47 PM, Mika Westerberg wrote:
> On Wed, Feb 08, 2012 at 09:53:44AM -0700, H Hartley Sweeten wrote:
>> Fix build breakage due to the following commits:
>> 
>> Commit bd5f12a24766c1f299def0a78b008d4746f528f2
>> ? ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics
>> 
>> Commit 257af9f9725aa8a863b306659208a031135d59e7
>> ? ARM: 7041/1: gpio-ep93xx: hookup the to_irq callback in the driver
>> 
>> The vision_ep9307 machine uses the ep93xx build-in gpios and needs to
>> include <mach/gpio-ep93xx.h> to pickup the defines.
>> 
>> The gpio_to_irq() call is now a callback to the gpio-ep93xx.c driver
>> and cannot be used as a constant initializer for the .irq member of
>> struct i2c_board_info.
>> 
>> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
>> Acked-by: Ryan Mallon <rmallon@gmail.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

Russell,

Can this go to your Patch system or should it go thru the arm-soc tree?

The 3.2 kernel will not currently build with CONFIG_MACH_VISION_EP9307=y
and needs this patch.

Thanks,
Hartley
