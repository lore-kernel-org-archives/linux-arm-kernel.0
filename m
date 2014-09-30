From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 30 Sep 2014 22:31:19 +0200
Subject: [PATCH 2/2] arch: arm: samsung: Clean-up usage of
 CONFIG_SERIAL_SAMSUNG_UARTS symbol
In-Reply-To: <78824730.2ZeRMh8EV2@wuerfel>
References: <1412087695-10591-1-git-send-email-a.kesavan@samsung.com>
 <2267491.QlLoTEuT3L@wuerfel> <542AD5E6.9050503@gmail.com>
 <78824730.2ZeRMh8EV2@wuerfel>
Message-ID: <542B1317.5060704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30.09.2014 20:36, Arnd Bergmann wrote:
> On Tuesday 30 September 2014 18:10:14 Tomasz Figa wrote:
>>>> @@ -110,7 +110,7 @@ void __init s3c24xx_init_uartdevs(char *name,
>>>>                                   struct s3c24xx_uart_resources *res,
>>>>                                   struct s3c2410_uartcfg *cfg, int no)
>>>>  {
>>>> -#ifdef CONFIG_SERIAL_SAMSUNG_UARTS
>>>> +#ifdef CONFIG_SERIAL_SAMSUNG
>>>>         struct platform_device *platdev;
>>>>         struct s3c2410_uartcfg *cfgptr = uart_cfgs;
>>>>         struct s3c24xx_uart_resources *resp;
>>>
>>> Since you hardcode the number here now, you can actually drop this #ifdef.
>>
>> I believe what Abhilash did is correct, because this code is not needed
>> when there is no serial support enabled.
>>
> 
> I only added the #ifdef here because it was broken when
> CONFIG_SERIAL_SAMSUNG_UARTS was undefined.

Fair enough. This isn't really that much code to really care and most
(if not all) use cases have UART enabled anyway.

Best regards,
Tomasz
