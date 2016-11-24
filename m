From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Thu, 24 Nov 2016 23:10:09 +0100
Subject: [PATCH] ARM: pxa: ezx: fix a910 camera data
In-Reply-To: <20161124162955.3887066-1-arnd@arndb.de>
References: <20161124162955.3887066-1-arnd@arndb.de>
Message-ID: <e0bdf159-93f2-5ed7-1e28-7fb80707d6c7@datenfreihafen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24.11.2016 17:29, Arnd Bergmann wrote:
> The camera_supply_dummy_device definition is shared between a780 and a910,
> but only provided when the first is enabled and fails to build for a
> configuration with only a910:
> 
> arch/arm/mach-pxa/ezx.c:1097:3: error: 'camera_supply_dummy_device' undeclared here (not in a function)
> 
> This moves the definition into its own section.
> 
> Fixes: 6c1b417adc8f ("ARM: pxa: ezx: use the new pxa_camera platform_data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/ezx.c | 56 ++++++++++++++++++++++++++-----------------------

I wonder what we should do with ezx.c.

As far as I know neither Daniel nor Harald or myself are doing anything
with this devices anymore. Besides a basic compile test having an ack or
reviewed by from our side is a bit worthless. :/

I should still have some of these phones around in a box somewhere. If
there is someone with a good motivation and time to take over on this
platform we will find a way to get the person this devices.

Any takers? Robert? I guess you are already overloaded but you might
also have an interest. Worth asking :)

In the case nobody wants to pick up here what would you consider the
bets way forward? I could send a patch removing ezx platform support
from the kernel (basically ezx.c plus build support) or I can send a
patch marking it at least orphan in MAINTAINERS. Let me know what you think.

Daniel, Harald, if one of you is still interested in these and what to
pick up the work again, please speak up now. :)

regards
Stefan Schmidt
