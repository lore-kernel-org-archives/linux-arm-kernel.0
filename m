From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Sep 2018 14:45:52 -0700
Subject: [PATCH 2/2] pinctrl: bcm: add Northstar driver
In-Reply-To: <20180919210219.21921-2-zajec5@gmail.com>
References: <20180919210219.21921-1-zajec5@gmail.com>
 <20180919210219.21921-2-zajec5@gmail.com>
Message-ID: <da0992c4-f8c8-7e3c-6d54-35a8cfdcd7bc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2018 02:02 PM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> This driver provides support for Northstar mux controller. It differs
> from Northstar Plus one so a new binding and driver were needed.
> 
> Right now it includes support for SPI pins only which is caused by a
> lack of access to Broadcom's datasheet. SPI pins info was extracted from
> the Broadcom's SDK. Once more pins are discovered they can be added to
> the driver without breaking any existing setups.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---

[snip]

> +static const struct pinctrl_pin_desc ns_pinctrl_pins[] = {
> +	{ 0, "spi_clk" },
> +	{ 1, "spi_ss" },
> +	{ 2, "spi_mosi" },
> +	{ 3, "spi_miso" },
> +};

In case you are interested, here are the additional functions:

4: i2c_scl
5: i2c_sda

6: mdc
7: mdio

8: pwm0
9: pwm1
10: pwm2
11: pwm3

12: uart1_rx
13: uart1_tx
14: uart1_cts
15: uart1_rts

On BCM53012:

16: uart2_rx
17: uart2_tx
22: sdio_card_power_ctl
23: sdio_en_1p8

On BCM53013:

21: 25Mhz crystal output for I2S

Not an expert on pinctrl drivers, but it looks reasonable to me.
-- 
Florian
