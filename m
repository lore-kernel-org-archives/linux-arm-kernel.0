From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 5 Oct 2018 09:06:26 +0100
Subject: [PATCH] nvmem: lpc18xx_eeprom: fix compile warning
In-Reply-To: <20181005070313.GA2217@embeddedor.com>
References: <20181005070313.GA2217@embeddedor.com>
Message-ID: <cbd5708c-e06a-acfd-80af-34222bc2be1f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/18 08:03, Gustavo A. R. Silva wrote:
> Fix the following warning by removing unused variable ret:
> 
> drivers/nvmem/lpc18xx_eeprom.c: In function ?lpc18xx_eeprom_remove?:
> drivers/nvmem/lpc18xx_eeprom.c:258:6: warning: unused variable ?ret?
> [-Wunused-variable]
>    int ret;
>        ^~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

There is already a patch submitted fix this

  https://lore.kernel.org/patchwork/patch/995032/


-srini

> ---
>   drivers/nvmem/lpc18xx_eeprom.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
> index b42dbad..66cff1e 100644
> --- a/drivers/nvmem/lpc18xx_eeprom.c
> +++ b/drivers/nvmem/lpc18xx_eeprom.c
> @@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
>   static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>   {
>   	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
> -	int ret;
>   
>   	clk_disable_unprepare(eeprom->clk);
>   
> 
