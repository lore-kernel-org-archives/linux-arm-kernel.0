From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 2 Oct 2018 23:22:00 +0200
Subject: [PATCH] nvmem: lpc18xx_eeprom: remove an unused variable
In-Reply-To: <20181002211016.2638186-1-arnd@arndb.de>
References: <20181002211016.2638186-1-arnd@arndb.de>
Message-ID: <CAMRc=MfOMp5qpZLBBLKHTrziBBV2kD1ZMv7OD4E3M85G=G++bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wt., 2 pa? 2018 o 23:10 Arnd Bergmann <arnd@arndb.de> napisa?(a):
>
> drivers/nvmem/lpc18xx_eeprom.c: In function 'lpc18xx_eeprom_remove':
> drivers/nvmem/lpc18xx_eeprom.c:258:6: error: unused variable 'ret' [-Werror=unused-variable]
>
> Fixes: 226014d13fa5 ("nvmem: lpc18xx_eeprom: use devm_nvmem_register()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/nvmem/lpc18xx_eeprom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
> index b42dbaddb419..66cff1e2147a 100644
> --- a/drivers/nvmem/lpc18xx_eeprom.c
> +++ b/drivers/nvmem/lpc18xx_eeprom.c
> @@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
>  static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>  {
>         struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
> -       int ret;
>
>         clk_disable_unprepare(eeprom->clk);
>
> --
> 2.18.0
>

Hi Arnd,

I had already sent a fix for that with you in Cc:
https://lkml.org/lkml/2018/10/2/439

Best regards,
Bartosz
