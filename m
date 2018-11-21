From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 21 Nov 2018 08:36:49 +0100
Subject: [PATCH v2] tee: optee: log message if dynamic shm is enabled
In-Reply-To: <CAHqM-Qjr+5T1pMatJ=5MSsJvzaRqPybt_2TtyzHPwLnt=WjCEA@mail.gmail.com>
References: <CAHqM-Qjr+5T1pMatJ=5MSsJvzaRqPybt_2TtyzHPwLnt=WjCEA@mail.gmail.com>
Message-ID: <20181121073648.GA20049@jax.urgonet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Tue, Sep 11, 2018 at 06:09:02PM +0900, Victor Chong wrote:
> When dynamic shared memory support is enabled in the OP-TEE Trusted
> OS, it doesn't mean that the driver supports it, which can confuse
> users during debugging. Log a message when dynamic shared memory is
> enabled in the driver, to let users know for sure.
> 
> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Victor Chong <victor.chong@linaro.org>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
> v2:
> * Added patch description
> 
> [v1] lore.kernel.org/patchwork/patch/983949/
> 
>  drivers/tee/optee/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index e1aafe842d66..cca5c091e55a 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)
> 
>         optee_enable_shm_cache(optee);
> 
> +       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> +               pr_info("dynamic shared memory is enabled\n");
> +
>         pr_info("initialized driver\n");
>         return optee;
>  err:
> --
> 2.17.1

Looks good. I'm picking this up.

Thanks,
Jens
