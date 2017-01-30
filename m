From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Mon, 30 Jan 2017 13:15:54 +0200
Subject: [PATCH] i2c: busses: constify i2c_algorithm structures
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Message-ID: <2babe118-e7fa-c579-d00f-16ddcb466b69@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2017 08:06 PM, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
> Done using Coccinelle:
>
...
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6d81c56..a62c14c 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -822,7 +822,7 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
>  	return dev->functionality;
>  }
>
> -static struct i2c_algorithm i2c_dw_algo = {
> +static const struct i2c_algorithm i2c_dw_algo = {
>  	.master_xfer	= i2c_dw_xfer,
>  	.functionality	= i2c_dw_func,
>  };

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
