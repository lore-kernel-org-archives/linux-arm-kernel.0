From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 10 Feb 2012 08:46:40 +0200
Subject: [PATCH] ep93xx: fix build of vision_ep93xx.c
In-Reply-To: <201202080953.44853.hartleys@visionengravers.com>
References: <201202080953.44853.hartleys@visionengravers.com>
Message-ID: <20120210064640.GA3847@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 09:53:44AM -0700, H Hartley Sweeten wrote:
> Fix build breakage due to the following commits:
> 
> Commit bd5f12a24766c1f299def0a78b008d4746f528f2
> ? ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics
> 
> Commit 257af9f9725aa8a863b306659208a031135d59e7
> ? ARM: 7041/1: gpio-ep93xx: hookup the to_irq callback in the driver
> 
> The vision_ep9307 machine uses the ep93xx build-in gpios and needs to
> include <mach/gpio-ep93xx.h> to pickup the defines.
> 
> The gpio_to_irq() call is now a callback to the gpio-ep93xx.c driver
> and cannot be used as a constant initializer for the .irq member of
> struct i2c_board_info.
> 
> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
> Acked-by: Ryan Mallon <rmallon@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
