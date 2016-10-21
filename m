From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 21 Oct 2016 12:13:48 -0700
Subject: [PATCH 5/5] ARM: dts: Add LEGO MINDSTORTMS EV3 dts
In-Reply-To: <1477075018-20176-6-git-send-email-david@lechnology.com> (David
 Lechner's message of "Fri, 21 Oct 2016 13:36:57 -0500")
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-6-git-send-email-david@lechnology.com>
Message-ID: <7htwc51pn7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Lechner <david@lechnology.com> writes:

> This adds a device tree definition file for LEGO MINDSTORMS EV3.
>
> What is working:
>
> * Pin muxing
> * MicroSD card reader
> * UART on input port 1
>
> What is partially working:
>
> * Buttons - working after GPIO fix
> * LEDs - working after GPIO fix
> * Poweroff/reset - working after GPIO fix
> * Flash memory - driver loads but can't read the block devices - this is
>   probably due to the fact that we are not able to configure the SPI to
>   use DMA via device tree
> * EEPROM - there seems to be a hardware bug that causes the first byte
>   read to be corrupted - this can be worked around by adding an I2C stop
>   between writing the register and reading the data, but the at24 driver
>   does not have an option to do this
>
> What is not working/to be added later:
>
> * Display - waiting for "tiny DRM" to be mainlined
> * Speaker - needs new PWM sound driver
> * USB - waiting for OHCI and MUSB device tree support to be mainlined
> * ADC - needs new iio driver
> * GPIOs - broken because of recent changes to core gpio driver
> * Bluetooth - needs new driver for sequencing power/enable/clock
> * Input and output ports - need some sort of new phy or extcon driver
> * Battery - needs new power supply driver (depends on ADC iio driver)
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/boot/dts/Makefile     |   3 +-
>  arch/arm/boot/dts/lego-ev3.dts | 454 +++++++++++++++++++++++++++++++++++++++++

nit: can you name this da850-lego-ev3.dts

Though it's not very strictly enforced, we *try* to use the form
<soc>-<board>.dts.

Kevin
