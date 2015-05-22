From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 May 2015 08:17:21 -0600
Subject: [PATCH] coresight: etb: Remove simple announcement message
In-Reply-To: <1432122101-2233-1-git-send-email-broonie@kernel.org>
References: <1432122101-2233-1-git-send-email-broonie@kernel.org>
Message-ID: <CANLsYkyW44THumc5ebWnX-sa5zG7X0dv1_UEqUp9Av8c5PDegg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2015 at 05:41, Mark Brown <broonie@kernel.org> wrote:
> It's generally preferred that drivers not print initialisation messages on
> startup that don't contain information gained at runtime such as specific
> hardware revision information. This provides a small speedup on systems
> with serial consoles and keeps the boot less noisy.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 77d0f9c1118d..e34e34b8edfb 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -481,7 +481,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         if (ret)
>                 goto err_misc_register;
>
> -       dev_info(dev, "ETB initialized\n");

Linus Walleij started doing something interesting with the initial
printouts [1] and I think this is a better option than not printing
anything at all.

[1]. https://git.linaro.org/kernel/coresight.git/commitdiff/509133a2715367c2ec9f8026ff55a028d04cdae0?hp=0b81f7e469b846b1b56d19d4f8f1f476943856f6

>         return 0;
>
>  err_misc_register:
> --
> 2.1.4
>
