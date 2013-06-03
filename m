From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 2 Jun 2013 19:34:44 -0700
Subject: [PATCHv3 1/3] Add support for GMT G762/G763 PWM fan controller
In-Reply-To: <a7bfda1de9cce8044434369428341d3fb05cf42c.1370202835.git.arno@natisbad.org>
References: <cover.1370202835.git.arno@natisbad.org>
 <a7bfda1de9cce8044434369428341d3fb05cf42c.1370202835.git.arno@natisbad.org>
Message-ID: <20130603023444.GB11723@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 10:14:19PM +0200, Arnaud Ebalard wrote:
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  drivers/hwmon/Kconfig              |   10 +
>  drivers/hwmon/Makefile             |    1 +
>  drivers/hwmon/g762.c               | 1179 ++++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/g762.h |   51 ++
>  4 files changed, 1241 insertions(+)
>  create mode 100644 drivers/hwmon/g762.c
>  create mode 100644 include/linux/platform_data/g762.h
> 
[ ... ]

> +static inline int g762_read_byte(const struct i2c_client *client, u8 reg,
> +				 u8 *dest)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, reg);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to read reg %x02x, err %d\n",
> +			(int)reg, ret);

I would suggest to write a piece of test code for the above statement and
observe its output. "printf("%x02x\n", 0x1234);" should do.

Is the error message really needed ? If there is a persistent error,
it will clog the log.

Thanks,
Guenter
