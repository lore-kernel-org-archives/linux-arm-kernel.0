From: pramod.gurav.etc@gmail.com (pramod gurav)
Date: Tue, 22 Jul 2014 17:20:15 +0530
Subject: [PATCH 02/19] mfd: max8925-i2c: Fix 'blank line after
 declarations' warning
In-Reply-To: <1406027485-15657-3-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
 <1406027485-15657-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CAMf-jSn5zZ1FBt+atzB9frZZ6yu_OTTfmJF2e7CEgQDbdzytBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 4:41 PM, Lee Jones <lee.jones@linaro.org> wrote:
> This is part of an effort to clean-up the MFD subsystem.
>
> WARNING: Missing a blank line after declarations
> +       int ret;
> +       ret = i2c_add_driver(&max8925_driver);
>
> total: 0 errors, 1 warnings, 275 lines checked
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/max8925-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
> index a83eed5..ecbe78e 100644
> --- a/drivers/mfd/max8925-i2c.c
> +++ b/drivers/mfd/max8925-i2c.c
> @@ -257,9 +257,11 @@ static struct i2c_driver max8925_driver = {
>  static int __init max8925_i2c_init(void)
>  {
>         int ret;
> +
>         ret = i2c_add_driver(&max8925_driver);
>         if (ret != 0)
>                 pr_err("Failed to register MAX8925 I2C driver: %d\n", ret);
> +
There are more such changes required in this file. If they could go
with this, will be good.
>         return ret;
>  }
>  subsys_initcall(max8925_i2c_init);
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Thanks and Regards
Pramod
