From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Thu, 30 Nov 2017 11:12:51 +0000
Subject: [PATCH] crypto: stm32: fix module device table name
In-Reply-To: <20171130110433.15811-1-clabbe.montjoie@gmail.com>
References: <20171130110433.15811-1-clabbe.montjoie@gmail.com>
Message-ID: <1a0e7db7-8634-8b2b-12a9-8df6846a1a37@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin


Thank you for the patch.


On 30/11/17 12:04, Corentin Labbe wrote:
> This patch fix the following build failure:
>    CC [M]  drivers/crypto/stm32/stm32-cryp.o
> In file included from drivers/crypto/stm32/stm32-cryp.c:11:0:
> drivers/crypto/stm32/stm32-cryp.c:1049:25: error: 'sti_dt_ids' undeclared here (not in a function)
>   MODULE_DEVICE_TABLE(of, sti_dt_ids);
>
> Let's replace sti_dt_ids with stm32_dt_ids which is just declared
> before.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>

> ---
>   drivers/crypto/stm32/stm32-cryp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
> index 098fad266c41..1807789b23f5 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -1046,7 +1046,7 @@ static const struct of_device_id stm32_dt_ids[] = {
>   	{ .compatible = "st,stm32f756-cryp", },
>   	{},
>   };
> -MODULE_DEVICE_TABLE(of, sti_dt_ids);
> +MODULE_DEVICE_TABLE(of, stm32_dt_ids);
>   
>   static int stm32_cryp_probe(struct platform_device *pdev)
>   {
