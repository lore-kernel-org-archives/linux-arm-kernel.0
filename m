From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 30 Aug 2018 12:23:16 -0500
Subject: [PATCH] fsl: remove redundant pointer 'priv'
In-Reply-To: <20180829092746.30674-1-colin.king@canonical.com>
References: <20180829092746.30674-1-colin.king@canonical.com>
Message-ID: <CADRPPNQxAZi4HahERZZdKDKpauh+pbw+PmDOe_nUXZvJbvJRng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 4:29 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer 'priv' is being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> variable 'priv' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Merged for next after updated the title prefix.

Thanks!
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index b60b77bfaffa..e58fcc9096e8 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -50,13 +50,10 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
>
>  static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
>  {
> -       struct dpio_priv *priv;
>         int error;
>         struct fsl_mc_device_irq *irq;
>         cpumask_t mask;
>
> -       priv = dev_get_drvdata(&dpio_dev->dev);
> -
>         irq = dpio_dev->irqs[0];
>         error = devm_request_irq(&dpio_dev->dev,
>                                  irq->msi_desc->irq,
> --
> 2.17.1
>
