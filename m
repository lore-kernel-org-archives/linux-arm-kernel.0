From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jul 2018 08:04:32 +0100
Subject: [PATCH v2 09/10] mfd: 88pm860x-i2c: switch to i2c_lock_bus(...,
 I2C_LOCK_SEGMENT)
In-Reply-To: <20180620051803.12206-10-peda@axentia.se>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-10-peda@axentia.se>
Message-ID: <20180704070432.GF20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018, Peter Rosin wrote:

> Locking the root adapter for __i2c_transfer will deadlock if the
> device sits behind a mux-locked I2C mux. Switch to the finer-grained
> i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
> sit behind a mux-locked mux, the two locking variants are equivalent.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mfd/88pm860x-i2c.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

If Wolfram is happy with this, then I am.

Since this file sees few changes - please merge through the I2C tree.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
