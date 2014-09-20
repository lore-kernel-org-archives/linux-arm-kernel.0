From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Sat, 20 Sep 2014 12:19:24 +0800
Subject: [PATCH] drivers/usb/host/ehci-xilinx-of.c: Include
 "linux/of_irq.h" to avoid compiling error
In-Reply-To: <540D3C89.6080702@monstr.eu>
References: <540738C7.5000106@gmail.com> <540D3C89.6080702@monstr.eu>
Message-ID: <541D004C.6020108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maintainers:

Please help check this patch, when you have time.

Thanks.

On 09/08/2014 01:20 PM, Michal Simek wrote:
> On 09/03/2014 05:50 PM, Chen Gang wrote:
>> Need include it for irq_of_parse_and_map(), the related error with
>> allmodconfig under microblaze:
>>
>>   drivers/usb/host/ehci-xilinx-of.c: In function ?ehci_hcd_xilinx_of_probe?:
>>   drivers/usb/host/ehci-xilinx-of.c:156:2: error: implicit declaration of function ?irq_of_parse_and_map? [-Werror=implicit-function-declaration]
>>     irq = irq_of_parse_and_map(dn, 0);
>>     ^
>>
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>>  drivers/usb/host/ehci-xilinx-of.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
>> index fe57710..a232836 100644
>> --- a/drivers/usb/host/ehci-xilinx-of.c
>> +++ b/drivers/usb/host/ehci-xilinx-of.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>>  
>>  /**
>>   * ehci_xilinx_port_handed_over - hand the port out if failed to enable it
>>
> 
> Acked-by: Michal Simek <monstr@monstr.eu>
> 
> Thanks,
> Michal
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
