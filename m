From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Feb 2016 18:39:53 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <56C21518.5030606@roeck-us.net>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de> <56C1F19F.8090100@roeck-us.net>
 <20160215170025.GJ12289@pengutronix.de> <56C21518.5030606@roeck-us.net>
Message-ID: <56C21B79.8000408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/02/16 18:12, Guenter Roeck wrote:

[...]

>
> I added some debugging on top of your patch, and get:
>
> platform basic-mmio-gpio.1.auto: Device node exists
> [/smb/motherboard/iofpga at 7,00000000/sysreg at 00000/sys_led at 08],
> of_driver_match_device() failed
> platform basic-mmio-gpio.1.auto: platform_match_id() succeeded
> platform basic-mmio-gpio.2.auto: Device node exists
> [/smb/motherboard/iofpga at 7,00000000/sysreg at 00000/sys_mci at 48],
> of_driver_match_device() failed
> platform basic-mmio-gpio.2.auto: platform_match_id() succeeded
> platform basic-mmio-gpio.3.auto: Device node exists
> [/smb/motherboard/iofpga at 7,00000000/sysreg at 00000/sys_flash at 4c],
> of_driver_match_device() failed
> platform basic-mmio-gpio.3.auto: platform_match_id() succeeded
>
> So it isn't the mmc driver failing to instantiate directly,
> but (I think) vexpress-sysreg.
>

That's correct, I could reproduce this issue and reported with similar
analysis earlier [1]

--
Regards,
Sudeep

[1] http://www.spinics.net/lists/arm-kernel/msg483107.html
