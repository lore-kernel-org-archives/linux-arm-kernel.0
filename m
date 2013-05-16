From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 16 May 2013 13:13:35 -0700
Subject: [PATCH v2] clk: si5351: declare all device IDs for module loading
In-Reply-To: <20130516174916.2daa49b6@armhf>
References: <20130516174916.2daa49b6@armhf>
Message-ID: <20130516201335.12127.99310@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jean-Francois Moine (2013-05-16 08:49:16)
> When the si5351 driver is a kernel module, it is loaded into memory
> from its i2c device IDs, but not from its DT compatible properties.
> 
> This patch declares the i2c device IDs of all chip variants.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Taken into clk-next.

Thanks,
Mike

> ---
> v2: subject change - was "ARM: dove: ..."
> --- 
>  drivers/clk/clk-si5351.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index 8927284..9ebdddd 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -1490,7 +1490,10 @@ static int si5351_i2c_probe(struct i2c_client *client,
>  }
>  
>  static const struct i2c_device_id si5351_i2c_ids[] = {
> -       { "silabs,si5351", 0 },
> +       { "si5351a", 0 },
> +       { "si5351a-msop", 0 },
> +       { "si5351b", 0 },
> +       { "si5351c", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, si5351_i2c_ids);
> 
> 
> -- 
> Ken ar c'henta? |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
