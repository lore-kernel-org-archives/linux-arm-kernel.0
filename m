From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Jul 2012 13:56:44 +0200
Subject: [PATCH] mfd: Implement devicetree support for AB8500 Btemp
In-Reply-To: <50000635.70102@stericsson.com>
References: <mailman.377.1341937217.1590.linaro-dev@lists.linaro.org>
 <50000635.70102@stericsson.com>
Message-ID: <50000CFC.5040402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> @@ -964,11 +966,13 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
>>>    {
>>>        int irq, i, ret = 0;
>>>        u8 val;
>>> -     struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
>>
>> I already told you about this.
> your previous comment was: "No, it's meant to work with _both_ platform
> and Device Tree registation."

Right.

> Why is this required when platform specific information/file is removed?

It's not being removed, it's just not allowed to be upstreamed. Once we 
enforce Device Tree only booting, we'll go round and remove that 
capability from the drivers. Until then, you must ensure all Device Tree 
enablement works in parallel with platform registration.

Concentrate on enabling the drivers for DT for now and we'll extract 
platform data support later.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
