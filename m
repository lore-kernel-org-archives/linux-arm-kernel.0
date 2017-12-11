From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Mon, 11 Dec 2017 14:31:09 +0000
Subject: [PATCH] crypto: stm32: fix modular build
In-Reply-To: <20171211114752.3637710-1-arnd@arndb.de>
References: <20171211114752.3637710-1-arnd@arndb.de>
Message-ID: <cfa89fc5-8604-f92c-5f78-78e461e3e72a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This issue was reported a few days ago, and Herbert applied the patch 2 
minutes before you send the mail (see 
[https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg29762.html]).

Anyway, thank you for reporting this.

Fabien


On 11/12/17 12:47, Arnd Bergmann wrote:
> Building the stm32 crypto suport as a loadable module causes a build
> failure from a simple typo:
>
> drivers/crypto/stm32/stm32-cryp.c:1035:25: error: 'sti_dt_ids' undeclared here (not in a function); did you mean 'stm32_dt_ids'?
>
> This renames the reference to point to the correct symbol.
>
> Fixes: 9e054ec21ef8 ("crypto: stm32 - Support for STM32 CRYP crypto module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/crypto/stm32/stm32-cryp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
> index 459755940632..cf1dddbeaa2c 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -1032,7 +1032,7 @@ static const struct of_device_id stm32_dt_ids[] = {
>   	{ .compatible = "st,stm32f756-cryp", },
>   	{},
>   };
> -MODULE_DEVICE_TABLE(of, sti_dt_ids);
> +MODULE_DEVICE_TABLE(of, stm32_dt_ids);
>   
>   static int stm32_cryp_probe(struct platform_device *pdev)
>   {
