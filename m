From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 2 May 2015 22:48:59 +0200
Subject: [PATCH 1/2] stmac: add dwmac glue for NXP 18xx/43xx family
In-Reply-To: <3200125.o3jqXuyPfG@wuerfel>
References: <1430584842-23408-1-git-send-email-manabian@gmail.com>
 <1430584842-23408-2-git-send-email-manabian@gmail.com>
 <3200125.o3jqXuyPfG@wuerfel>
Message-ID: <CAGhQ9VypQsxZZfdyMLhhNoMpCLRf8XSwUoGuhHPgev1gRitTsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2 May 2015 at 21:31, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 02 May 2015 18:40:41 Joachim Eastwood wrote:
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -36,6 +36,7 @@ static const struct of_device_id stmmac_dt_ids[] = {
>>         { .compatible = "rockchip,rk3288-gmac", .data = &rk3288_gmac_data},
>>         { .compatible = "amlogic,meson6-dwmac", .data = &meson6_dwmac_data},
>>         { .compatible = "allwinner,sun7i-a20-gmac", .data = &sun7i_gmac_data},
>> +       { .compatible = "nxp,lpc1850-dwmac", .data = &lpc18xx_dwmac_data},
>>         { .compatible = "st,stih415-dwmac", .data = &stih4xx_dwmac_data},
>>         { .compatible = "st,stih416-dwmac", .data = &stih4xx_dwmac_data},
>>         { .compatible = "st,stid127-dwmac", .data = &stid127_dwmac_data},
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
>>
>
> Any chance you could turn this around and do the probing in the normal
> order, with a platform driver that registers to your compatible string
> and calls into a common base module?

I can see what I can come up with.

> Unfortunately, something went wrong when we first started adding platform
> specific hacks to the driver. I tried to fix it up back then, and IIRC
> it was agreed that it should be changed but my patches for some reason
> missed out on getting merged and the mistake propagated afterwards.

Do you happen to have a link to these patches so I could take a look?

> It should be fairly straightforward to split the probe function
> into two and export a function that takes a device and a stmmac_of_data
> pointer as arguments, and declare a module_platform_driver in your
> code.

regards,
Joachim Eastwood
