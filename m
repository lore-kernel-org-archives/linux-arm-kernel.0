From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 9 Nov 2017 14:40:10 +0200
Subject: [PATCH 2/3] EDAC: ti: add support for TI keystone and DRA7xx EDAC
In-Reply-To: <1510228204.3471.44.camel@pengutronix.de>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
 <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510228204.3471.44.camel@pengutronix.de>
Message-ID: <37f0e3e2-f166-0e53-5905-173be9b995c3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/17 13:50, Jan L?bbe wrote:
> On Tue, 2017-11-07 at 22:38 +0200, Tero Kristo wrote:
>> +       if (edac_mc_add_mc(mci)) {
>> +               pr_err("%s: Failed to register mci.\n", __func__);
>> +               return -ENOMEM;
> This leaks the allocated mci structure in the error case.
> 
>> +       }
>> +
>> +       /* add EMIF ECC error handler */
>> +       error_irq = platform_get_irq(pdev, 0);
>> +       if (!error_irq) {
>> +               dev_err(dev, "DDR3 EDAC irq number not defined\n");
>> +               return ret;
> This leaves the mc registered in the error case.

I am too much used to devm_alloc nowadays I guess... I'll fix these for 
v2 and maybe re-arrange the irq alloc with rest of the code.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
