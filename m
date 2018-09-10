From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 10 Sep 2018 10:20:09 +0100
Subject: Fwd: [PATCH] tee: optee: log message if dynamic shm is enabled
In-Reply-To: <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com>
References: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
 <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com>
Message-ID: <20180910092009.y2p5n5owozaz6etw@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 05:57:28PM +0900, Victor Chong wrote:

This (empty) patch description seems unusually terse! Surely there
should be some clues in the description about why this messages
deserves user/dev/admin attention...


> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Victor Chong <victor.chong@linaro.org>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
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
