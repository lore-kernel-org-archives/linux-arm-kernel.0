From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Jul 2010 01:18:03 +0100
Subject: [alsa-devel] [PATCH 2/2] ARM: S3C64XX: Add audio support to SmartQ
In-Reply-To: <4c2e7f40.d37b0e0a.2178.3d69@mx.google.com>
References: <4c2e7f40.d37b0e0a.2178.3d69@mx.google.com>
Message-ID: <20100703001803.GB3869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 03, 2010 at 01:40:24AM +0200, Maurus Cuelenaere wrote:

> +static struct i2c_board_info smartq_i2c_devs[] __initdata = {
> +	{ I2C_BOARD_INFO("wm8750", 0x1a), },
> +};

It'd be slightly nicer to register with the actual chip ID and make sure
the driver can handle it - it'll avoid the potential for confusion.
