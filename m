From: stefan@agner.ch (Stefan Agner)
Date: Mon, 06 Aug 2018 14:21:52 +0200
Subject: [PATCH v8 3/3] dmaengine: fsl-edma: add ColdFire mcf5441x edma
 support
In-Reply-To: <CAJKOXPe=+KCwxJULZ5RPpZtemrPr2YARFFxH4jEQsA0bVzrrBA@mail.gmail.com>
References: <20180803193244.12084-1-angelo@sysam.it>
 <20180803193244.12084-3-angelo@sysam.it>
 <CAJKOXPe=+KCwxJULZ5RPpZtemrPr2YARFFxH4jEQsA0bVzrrBA@mail.gmail.com>
Message-ID: <0be6407cf2c5721ef59b6e3ae233394d@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.08.2018 10:09, Krzysztof Kozlowski wrote:
> On 3 August 2018 at 21:32, Angelo Dureghello <angelo@sysam.it> wrote:
>> This patch adds support for ColdFire mcf5441x-family edma
>> module.
>>
>> The ColdFire edma module is slightly different from fsl-edma,
>> so a new driver is added. But most of the code is common
>> between fsl-edma and mcf-edma so it has been collected into a
>> separate common module fsl-edma-common (patch 1/3).
>>
>> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
[...]
>> diff --git a/include/linux/platform_data/dma-mcf-edma.h b/include/linux/platform_data/dma-mcf-edma.h
>> new file mode 100644
>> index 000000000000..9a1819acb28f
>> --- /dev/null
>> +++ b/include/linux/platform_data/dma-mcf-edma.h
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Freescale eDMA platform data, ColdFire SoC's family.
>> + *
>> + * Copyright (c) 2017 Angelo Dureghello <angelo@sysam.it>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __MACH_MCF_EDMA_H__
>> +#define __MACH_MCF_EDMA_H__
> 
> The guard should rather match current location, e.g.
> __LINUX_PLATFORM_DATA_MCF_EDMA_H__
> 
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

So this revision fixed the issue we had seen with the previous version?
Do we know what it was exactly?

--
Stefan
