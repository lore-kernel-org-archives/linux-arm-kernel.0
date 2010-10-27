From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 27 Oct 2010 11:17:27 +0200
Subject: [PATCH] MMC: add support for the Marvell platform SDHCI controller
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FE1475AA356@IL-MB01.marvell.com>
References: <1288166860-28556-1-git-send-email-mike@compulab.co.il>
	<FCBE654890C0334289D0AD3AF4EF009FE1475AA356@IL-MB01.marvell.com>
Message-ID: <4CC7EE27.4030704@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/10 10:46, Saeed Bishara wrote:
>  
>  
>> +config MMC_SDHCI_MV
>> +	bool "SDHCI support on Marvell's SoC"
>> +	depends on MMC_SDHCI
>> +	depends on MMC_SDHCI_PLTFM
>> +	select MMC_SDHCI_IO_ACCESSORS
>> +	help
>> +	  This selects the Secure Digital Host Controller Interface in
>> +	  Marvell's SoC controllers.
>> +
>> +	  If you have a controller with this interface, say Y or M here.
>> +
>> +	  If unsure, say N.
>> +
> Mike, the config name and description is too generic as there are several sdhci
> controllers on Marvell devices (see like pxa), I suggest to name it SDHCI_DOVE
> and make it depends on ARCH_DOVE and modify the description accordingly.

No problem. That said, no ARCH_MPP for now, like it was in [1]?

[1] http://marc.info/?l=linux-kernel&m=128458441031769&q=raw


>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/mmc/host.h>
>> +#include "sdhci.h"
>> +#include "sdhci-pltfm.h"
> are those includes are realy needed? At least the delay.h and clk.h not needed for now.
> 
> saeed


-- 
Sincerely yours,
Mike.
