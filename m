From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue, 22 Jul 2014 14:51:53 +0300
Subject: [PATCH v2 1/4] mfd: pm8xxx-spmi: add support for Qualcomm SPMI
 PMICs
In-Reply-To: <20140722110341.GE8406@lee--X1>
References: <1405613855-27572-1-git-send-email-svarbanov@mm-sol.com>
 <1405613855-27572-2-git-send-email-svarbanov@mm-sol.com>
 <20140722110341.GE8406@lee--X1>
Message-ID: <53CE5059.4010107@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 02:03 PM, Lee Jones wrote:
> On Thu, 17 Jul 2014, Stanimir Varbanov wrote:
> 
>> From: Josh Cartwright <joshc@codeaurora.org>
>>
>> The Qualcomm SPMI PMIC chips are components used with the
>> Snapdragon 800 series SoC family.  This driver exists
>> largely as a glue mfd component, it exists to be an owner
>> of an SPMI regmap for children devices described in
>> device tree.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> Needs to be signed off by the author.
> 
>> ---
>>  drivers/mfd/Kconfig       |   16 +++++++++++
>>  drivers/mfd/Makefile      |    1 +
>>  drivers/mfd/pm8xxx-spmi.c |   63 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 80 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/mfd/pm8xxx-spmi.c
> 
> [...]
> 
>> +++ b/drivers/mfd/pm8xxx-spmi.c
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
> 
> There should be a '\n' here.

OK.

> 
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/spmi.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of_platform.h>
> 
> [...]
> 
>> +MODULE_DESCRIPTION("PM8XXX SPMI PMIC driver");
>> +MODULE_ALIAS("platform:" KBUILD_MODNAME);

I will change this to:

MODULE_ALIAS("spmi:pm8xxx-spmi");

>> +MODULE_AUTHOR("The Linux Foundation");
> 
> The Linux Foundation did not write this patch.

OK, I will change the author or remove the tag completely.

> 
>> +MODULE_LICENSE("GPL v2");
> 
> Appart from that:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Thanks. I will resend the whole patch set with your acks.

-- 
regards,
Stan
