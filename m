From: pieterg@gmx.com (pieterg)
Date: Sat, 31 Jul 2010 09:26:03 +0200
Subject: [PATCH] PXA: Colibri320: Add M41T00 RTC support
In-Reply-To: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
References: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201007310926.03292.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 July 2010 04:30:53 Marek Vasut wrote:
> +#if defined(CONFIG_RTC_DRV_DS1307) ||
> defined(CONFIG_RTC_DRV_DS1307_MODULE) 
> +static mfp_cfg_t colibri_pxa320_i2c_pin_config[] __initdata = { 
> +	GPIO32_I2C_SCL, 
> +	GPIO33_I2C_SDA,
> +};

Should the i2c pins really depend on the DS1307 config?
On my board, I use a different rtc. So I do need the I2C pins to be 
configured, but I don't need the DS1307.

A few weeks ago I submitted

[PATCH 4/5] colibri-pxa3xx: add i2c support

which initializes the i2c gpio's, depending on CONFIG_I2C || 
CONFIG_I2C_MODULE

(but the patch was rejected, argueing that people might want to use 
different gpio's for i2c)

Rgds, Pieter
