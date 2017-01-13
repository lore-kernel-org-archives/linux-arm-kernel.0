From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 13 Jan 2017 17:34:10 +0530
Subject: [PATCH v3] ARM: dts: Add LEGO MINDSTORMS EV3 dts
In-Reply-To: <1484253167-27568-1-git-send-email-david@lechnology.com>
References: <1484253167-27568-1-git-send-email-david@lechnology.com>
Message-ID: <3066d614-0676-319a-6149-6d723e1cf35f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 January 2017 02:02 AM, David Lechner wrote:
> This adds a device tree definition file for LEGO MINDSTORMS EV3.
> 
> What is working:
> 
> * Pin muxing
> * Pinconf
> * GPIOs
> * MicroSD card reader
> * UART on input port 1
> * Buttons
> * LEDs
> * Poweroff/reset
> * Flash memory
> * EEPROM
> * USB host port
> * USB peripheral port
> 
> What is not working/to be added later:
> 
> * Speaker - have patch submitted to get pwm-beeper working - maybe someday
>   it will have a real sound driver that uses PRU
> * A/DC chip - have driver submitted and accepted - waiting for ack on
>   device tree bindings
> * Display - waiting for "simple DRM" to be mainlined
> * Bluetooth - needs new driver for sequencing power/enable/clock
> * Input and output ports - need some sort of new phy or extcon driver as
>   well as PRU UART and PRU I2C drivers
> * Battery indication - needs new power supply driver
> 
> Note on flash partitions:
> 
> These partitions are based on the official EV3 firmware from LEGO. It is
> expected that most users of the mainline kernel on EV3 will be booting from
> an SD card while retaining the official firmware in the flash memory.
> Furthermore, the official firmware uses an ancient U-Boot (2009) that has
> no device tree support. So, it makes sense to have this partition table in
> the EV3 device tree file. In the unlikely case that anyone does create their
> own firmware image with different partitioning, they can use a modern
> U-Boot in their own firmware image that modifies the device tree with the
> custom partitions.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

There are couple of checkpatch errors that show up. The compatible
"lego,ev3" needs to be documented in
Documentation/devicetree/bindings/arm/davinci.txt

"at24,24c128" is undocumented. Is that an atmel chip on the EV3? If the
manufacturer name is not clear,
Documentation/devicetree/bindings/eeprom/eeprom.txt advises using just
"24c128"

Finally, lego needs to be added to
Documentation/devicetree/bindings/vendor-prefixes.txt

Can you please submit the documentation portions as separate patches in
a series along with this patch.

Thanks,
Sekhar
