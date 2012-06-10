From: marex@denx.de (Marek Vasut)
Date: Sun, 10 Jun 2012 13:53:05 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <1339242351-8797-1-git-send-email-marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
Message-ID: <201206101353.06018.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,

> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.

[...]

> +struct mxs_i2c_speed_config {
> +	uint32_t	timing0;
> +	uint32_t	timing1;
> +	uint32_t	timing2;
> +};
> +
> +/* Timing values for the default 24MHz clock supplied into the i2c block.

Thinking about these further -- does anyone have any idea how these numbers were 
derived? And possibly even formula for that?

And maybe we should somehow make sure the source runs on 24MHz (how?).

> */ +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
> +	.timing0	= 0x00780030,
> +	.timing1	= 0x00800030,
> +	.timing2	= 0x0015000d,
> +};
> +
> +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> +	.timing0	= 0x000f0007,
> +	.timing1	= 0x001f000f,
> +	.timing2	= 0x0015000d,
> +};

[...]

Best regards,
Marek Vasut
