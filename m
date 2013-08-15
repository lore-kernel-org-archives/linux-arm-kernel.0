From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 15 Aug 2013 11:29:19 +0800
Subject: [PATCH 10/29] drivers/watchdog/nuc900_wdt.c: simplify use of
 devm_ioremap_resource
In-Reply-To: <520C482F.5090806@roeck-us.net>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376471493-22215-11-git-send-email-Julia.Lawall@lip6.fr>
 <520C482F.5090806@roeck-us.net>
Message-ID: <CAKT61h9DCnJZkgi4O6jq41tfd1mS2bZm9vEu=RfvXk_0EWfObQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/15 Guenter Roeck <linux@roeck-us.net>:
> On 08/14/2013 02:11 AM, Julia Lawall wrote:
>>
>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> Remove unneeded error handling on the result of a call to
>> platform_get_resource when the value is passed to devm_ioremap_resource.
>>
>> A simplified version of the semantic patch that makes this change is as
>> follows: (http://coccinelle.lip6.fr/)
>>
>> // <smpl>
>> @@
>> expression pdev,res,n,e,e1;
>> expression ret != 0;
>> identifier l;
>> @@
>>
>> - res = platform_get_resource(pdev, IORESOURCE_MEM, n);
>>    ... when != res
>> - if (res == NULL) { ... \(goto l;\|return ret;\) }
>>    ... when != res
>> + res = platform_get_resource(pdev, IORESOURCE_MEM, n);
>>    e = devm_ioremap_resource(e1, res);
>> // </smpl>
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Wan Zongshun <mcuos.com@gmail.com>

Thanks for your patch.

>
>



-- 
Wan ZongShun.
www.mcuos.com
