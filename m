From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 10:15:39 -0700
Subject: [GIT PULL] pxa for v4.4
In-Reply-To: <878u72zlif.fsf@belgarion.home>
References: <878u72zlif.fsf@belgarion.home>
Message-ID: <20151023171539.GB2224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 09:00:40PM +0200, Robert Jarzmik wrote:
> Hi Arnd, Kevin and Olof,
> 
> This is the pxa pull request for 4.4 cycle. It is mainly magician enhancement
> and fixes. Could you please consider pulling ?
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git pxa-for-4.4

Hi Robert,

I'm glad to see all this activity on PXA! You're reaching the amount of new
stuff that it's time to start splitting up in topics. I'll merge this branch
for this release, but I'm also going to go through below and show you how this
can/should be split up in the future.


First, take a look at our tree and how it's organized. Look at my presentation
from ELC 2014, or Arnd's from this year, to get an idea of the philosophy we
use and roughly how we categorize patches.

> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       ARM: pxa: remove incorrect __init annotation on pxa27x_set_pwrmode

This is a fix or cleanup.

> Jarkko Nikula (1):
>       ARM: pxa: Remove unused clock_enable field from struct pxa2xx_spi_master

Cleanup.

> 
> Petr Cvek (22):
>       ARM: pxa: magician: Fix indentation in machine files
>       ARM: pxa: magician: Print more specific error message for global GPIOs
>       ARM: pxa: magician: Optimize debug messages for LCD power
>       ARM: pxa: magician: Change description of LCD power GPIO
>       ARM: pxa: magician: Add new discovered EGPIO pins
>       ARM: pxa: magician: Rename abstract LCD GPIOs
>       ARM: pxa: magician: Optimize powerup delays for Samsung LCD
>       ARM: pxa: magician: Rename charger cable detection EGPIOs
>       ARM: pxa: magician: Optimize Samsung LCD refresh to 50Hz
>       ARM: pxa: magician: Fix and add charging detection functions
>       ARM: pxa: magician: Fix platform data for both PXA27x I2C controllers
>       ARM: pxa: magician: Fix redundant GPIO request for pxaficp_ir
>       ARM: pxa: magician: Fix support for Intel Strata NOR Flash
>       ARM: pxa: magician: Fix wrongly enabled USB host ports
>       ARM: pxa: magician: Remove definition of the STUART port
>       ARM: pxa: magician: Add debug message for backlight brightness function
>       ARM: pxa: magician: Add missing regulator for PWM backlight
>       ARM: pxa: magician: Move platform_add_devices() to the end of magician_init()
>       ARM: pxa: magician: Change comments to be more informative
>       ARM: pxa: magician: Add support for MAX1587A Vcore regulator
>       ARM: pxa: magician: Add support for PXA27x UDC
>       ARM: pxa: magician: Remove pdata for pasic3-leds

Most of these are fixes/cleanups. With a burst of patches like this it can
sometimes be hard to rip them apart and put some in one bucked and others in
another. Feel free to keep them in a separate topic in that case
(magician-cleanup or similar)

> Robert Jarzmik (2):
>       ARM: pxa: add resources to pxaficp_ir
>       ARM: pxa: mioa701: add wm9713 codec

Board code, of which we tend to have almost none these days. :-)

> Thierry Reding (17):
>       ARM: pxa: colibri-pxa270-income: Use PWM lookup table
>       ARM: pxa: ezx: Use PWM lookup table
>       ARM: pxa: hx4700: Remove unused field initializers
>       ARM: pxa: lpd270: Use PWM lookup table
>       ARM: pxa: magician: Use PWM lookup table
>       ARM: pxa: mainstone: Use PWM lookup table
>       ARM: pxa: mioa701: Use PWM lookup table
>       ARM: pxa: palm27x: Use PWM lookup table
>       ARM: pxa: palmte2: Use PWM lookup table
>       ARM: pxa: pcm990: Use PWM lookup table
>       ARM: pxa: raumfeld: Use PWM lookup table
>       ARM: pxa: viper: Use PWM lookup table
>       ARM: pxa: palmtc: Use PWM lookup table
>       ARM: pxa: cm-x300: Use PWM lookup table
>       ARM: pxa: tavorevb: Use PWM lookup table
>       ARM: pxa: z2: Use PWM lookup table
>       ARM: pxa: zylonite: Use PWM lookup table

This could also be a topic on its own. We'd merge it into the cleanup branch at
our end, but you can provide it as a separate branch if you want.

> Uwe Kleine-K??nig (1):
>       ARM: pxa: raumfeld: make some variables static

cleanup.


Given that the bulk above was cleanup, that's also where I merged this branch
this time around.

Don't hesitate to ask if you have questions on how to handle this down the
road.


-Olof
