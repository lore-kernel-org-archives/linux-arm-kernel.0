From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 09 Jan 2015 13:46:10 +0100
Subject: [PATCH 2/2] leds: tlc59116: Driver for the TI 16 Channel i2c LED
 driver
In-Reply-To: <1420763178-10115-3-git-send-email-andrew@lunn.ch>
References: <1420763178-10115-1-git-send-email-andrew@lunn.ch>
 <1420763178-10115-3-git-send-email-andrew@lunn.ch>
Message-ID: <op.xr64e8gt2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, 09 Jan 2015 01:26:18 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> The TLC59116 is an I2C bus controlled 16-channel LED driver.  Each LED
> output has its own 8-bit fixed-frequency PWM controller to control the
> brightness of the LED.
>
> This is based on a driver from Belkin, but has been extensively
> rewritten.
>
<snip>

> +config LEDS_TLC59116
> +	tristate "LED driver for TLC59116F controllers"
> +	depends on LEDS_CLASS && I2C

I think you need "select REGMAP_I2C" as well.

> +	help
> +	  This option enables support for Texas Instruments TLC59116F
> +	  LED controller.
> +
>  config LEDS_MAX8997
>  	tristate "LED support for MAX8997 PMIC"
>  	depends on LEDS_CLASS && MFD_MAX8997



Imre
