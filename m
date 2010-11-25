From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Nov 2010 13:17:09 +0100
Subject: [PATCH 1/1] arm: imx: share imx5x_register_gpios for mach-mx5
In-Reply-To: <AANLkTimy3qV+ZXs9urdTX2rq=0XrKEtbt2m8x+eBvMce@mail.gmail.com>
References: <1290695312-30031-1-git-send-email-linuxzsc@gmail.com>
	<20101125062924.GD4693@pengutronix.de>
	<AANLkTimvcAS3BmjtaYCMzHcv=q2znS2zy_Dto_OMJeWh@mail.gmail.com>
	<20101125074244.GE4693@pengutronix.de>
	<AANLkTikZkXRmddSYN0-7eSBKO_BpXbz+xuJRhDfKeU02@mail.gmail.com>
	<20101125081406.GG4693@pengutronix.de>
	<20101125084302.GN6017@pengutronix.de>
	<AANLkTimy3qV+ZXs9urdTX2rq=0XrKEtbt2m8x+eBvMce@mail.gmail.com>
Message-ID: <20101125121709.GH4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, Nov 25, 2010 at 07:10:27PM +0800, Richard Zhao wrote:
> Thanks. I go through the code again. Here is mx50 adding plan:
> 1. basic memory map definitions
> Add it in individual arch/arm/plat-mxc/include/mach/mx50.h
I hope the memory map itself goes into arch/arm/mach-mx5/mm-mx50.c or
similar.  The constants go into include/mach/mx50.h though.

> 2. clock.c crm_regs.h
> clock tree is different. mx50 use arch/arm/mach-mx5/clock-mx50.c.
> Possibly individual crm_regs.h too.
Then please use proper prefixes (and maybe make the definitions local to
a .c file if possible).
> 3. iomux
> individual arch/arm/plat-mxc/include/mach/iomux-mx50.h
is mx50 using iomux-v3?

> 4. gpio
> Add it in arch/arm/plat-mxc/gpio.c under macro CONFIG_SOC_IMX50.
yes

> 5. irq
> Add it in individual arch/arm/plat-mxc/include/mach/mx50.h
yes, the constants go there

> 6. device and resource.
> Dynamicly add device. SoC level data is in arch/arm/plat-mxc/devices
> init section, plat data is in board level file.
most of the time yes.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
