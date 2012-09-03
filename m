From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 3 Sep 2012 16:28:09 +0200
Subject: [PATCH 0/3] gpio-twl4030: add new device tree properties
In-Reply-To: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <5044BE79.4040100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Vaibhav for the omap3-evm

Hi Florian,

On 09/03/2012 03:54 PM, Florian Vaussard wrote:
> A number of platform data are missing when using twl4030/gpio from a
> device tree.

Yeah, I know, I was too lazy when I did the DT conversion at that time :-)

Many thanks for completing the work.

>  This patchset adds the missing properties, updates
> existing device trees and updates the documentation of bindings.
> It mainly enables LEDA and LEDB outputs, as well as pullups /
> pulldowns on GPIOs.
> 
> The 1st patch changes the device driver.
> The 2nd patch updates the device trees for BeagleBoard and omap3-evm.
> The 3rd patch updates the documentation of bindings.

OK, that's a nit, but in general, you'd better introduce the binding
before using it.

The binding documentation could/should be updated along with the driver
change that does introduce the binding. You could just merged patch #1
and #3.

> Tested:
> - Boot tested on Gumstix Overo for "ti,use-leds". Corresponding
>   patch is not provided, as the device tree is not yet merged.
>   The support can be found in the git tree [1], branch
>   omap3-devel-dt-overo.
> - Device trees for BeagleBoard and omap3-evm were compiled, but not
>   tested on hardware.
> 
> Would someone be willing to test on BeagleBoard / omap3-evm?

I'll try to do it on Beagle. This is the least I can do since I did not
do the job myself :-)

I added vaibhav as well since I do not have any omap3-evm board.

> 
> Regards,
> Florian
> 
> [1] https://github.com/vaussard/linux.git (not safe for merge)
> 
> 
> Florian Vaussard (3):
>   gpio-twl4030: get platform data from device tree
>   gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM

Nit #2: the DTS file does not belong to the gpio subsystem. So you
should prefix them using the *convention* for ARM DTS patches:

arm/dts: omap3: Add gpio-twl4030 properties for BeagleBoard and omap3-EVM

Or maybe "ARM: dts: " because it looks like most people are using that
nowadays.

The convention for the gpio directory is similar:
gpio/twl4030: get platform data from device tree

>   gpio-twl4030: updates the bindings for new dt properties
> 
>  .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
>  arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
>  arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
>  drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
>  4 files changed, 98 insertions(+), 27 deletions(-)

Thanks,
Benoit
