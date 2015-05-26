From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 26 May 2015 17:20:24 +0900
Subject: [PATCH] pinctrl: zynq: change error code for pinctrl_register
 failure
In-Reply-To: <4437293.G26yCXqFQH@wuerfel>
References: <1432613909-13457-1-git-send-email-yamada.masahiro@socionext.com>
 <4437293.G26yCXqFQH@wuerfel>
Message-ID: <CAK7LNAQ3GbG0BCiESOnO1=qViXOer0StEEbjxUYumbGa73VgZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2015-05-26 17:12 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 26 May 2015 13:18:29 Masahiro Yamada wrote:
>> diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
>> index 04748a4..0ff653c 100644
>> --- a/drivers/pinctrl/pinctrl-zynq.c
>> +++ b/drivers/pinctrl/pinctrl-zynq.c
>> @@ -1141,7 +1141,7 @@ static int zynq_pinctrl_probe(struct platform_device *pdev)
>>
>>         pctrl->pctrl = pinctrl_register(&zynq_desc, &pdev->dev, pctrl);
>>         if (!pctrl->pctrl)
>> -               return -ENOMEM;
>> +               return -EINVAL;
>>
>>         platform_set_drvdata(pdev, pctrl);
>>
>>
>
> One choice seems as bad as the other to me ;-)
>
> Could we add a pinctrl_register_reason() variant that returns a meaningful
> error code as ERR_PTR?


I also thought of it.
I was wondering why pinctrl_register() did not return ERR_PTR.

Can we migrate to ERR_PTR in the long run?

 [1] Add pinctrl_register_reason()
 [2] Replace pinctrl_register() in each driver with
pinctrl_register_reason() one by one
 [3] Eventually, pinctrl_register will disappear
 [4] Rename pinctrl_register_reason() into pinctrl_register()


-- 
Best Regards
Masahiro Yamada
