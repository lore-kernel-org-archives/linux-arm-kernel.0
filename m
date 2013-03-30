From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sat, 30 Mar 2013 08:15:53 +0100
Subject: [PATCH v3 5/7] USB: EHCI: make ehci-atmel a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1303291600080.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291600080.1467-100000@iolanthe.rowland.org>
Message-ID: <51569129.8020106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 09:02 PM, Alan Stern :
> On Thu, 28 Mar 2013, Arnd Bergmann wrote:
> 
>> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>>
>> Separate the Atmel host controller driver from ehci-hcd host code
>> so that it can be built as a separate driver module.
>> This work is part of enabling multi-platform kernels on ARM;
>> however, note that other changes are still needed before Atmel can be
>> booted with a multi-platform kernel. This is currently planned for
>> Linux-3.11.
>>
>> With the infrastructure added by Alan Stern in patch 3e0232039
>> "USB: EHCI: prepare to make ehci-hcd a library module", we can
>> avoid this problem by turning a bus glue into a separate
>> module, as we do here for the Atmel bus glue.
> 
> Generally okay.
> 
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 01c1acb..8c564aa 100644
>> --- a/drivers/usb/host/ehci-atmel.c
>> +++ b/drivers/usb/host/ehci-atmel.c


I missed the patch itself but I reviewed it on the mailing-list archive.
So, here is my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks a lot for having taking care of this driver.

Best regards,


>> @@ -15,6 +15,19 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/of.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/usb.h>
>> +#include <linux/usb/hcd.h>
>> +#include <linux/io.h>
>> +#include <linux/dma-mapping.h>
> 
> While not absolutely necessary, it would be nice to have the #include 
> files in alphabetical order.
> 
>> +
>> +#include "ehci.h"
>> +
>> +#define DRIVER_DESC "EHCI atmel driver"
> 
> "atmel" should have a capital 'A'.
> 
> Alan Stern
> 
> 
> 


-- 
Nicolas Ferre
