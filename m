From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 10 May 2018 10:44:05 +0200
Subject: [PATCH 2/2] i2c: exynos5: remove pointless initializers
In-Reply-To: <20180509194532.28929-2-peda@axentia.se>
References: <20180509194532.28929-1-peda@axentia.se>
 <CGME20180509194552epcas3p4777026e41c7b34663eb11345e4f3d82d@epcas3p4.samsung.com>
 <20180509194532.28929-2-peda@axentia.se>
Message-ID: <b69f6656-3831-86ea-5f13-fc805d86b288@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.05.2018 21:45, Peter Rosin wrote:
> The variables are always assigned before use anyway.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-exynos5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index a2cbc779c33a..185fba37e830 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -707,7 +707,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  			struct i2c_msg *msgs, int num)
>  {
>  	struct exynos5_i2c *i2c = adap->algo_data;
> -	int i = 0, ret = 0, stop = 0;
> +	int i, ret, stop;

I hope gcc is smart enough to not complain in case of ret.
I think you can merge both patches into one.

Regards
Andrzej

>  
>  	if (i2c->suspended) {
>  		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
