From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 19 Mar 2015 09:34:11 +0000
Subject: [rtc-linux] [PATCH 08/13] rtc: at91rm9200: make IO endian agnostic
In-Reply-To: <20150319090217.GG14457@ns203013.ovh.net>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-9-git-send-email-ben.dooks@codethink.co.uk>
 <20150319090217.GG14457@ns203013.ovh.net>
Message-ID: <550A9813.5090909@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/15 09:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:53 Wed 18 Mar     , Ben Dooks wrote:
>> Change the __raw IO calls to readl/write_relaxed which makes the driver
>> endian agnostic to run properly on big endian systems.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> --
>> CC: Alessandro Zummo <a.zummo@towertech.it>
>> CC: rtc-linux at googlegroups.com
>> CC: linux-arm-kernel at lists.infradead.org
>> CC: Andrew Victor <linux@maxim.org.za>
>> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
>> CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> ---
>>  drivers/rtc/rtc-at91rm9200.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
>> index b4f7744..4106abc 100644
>> --- a/drivers/rtc/rtc-at91rm9200.c
>> +++ b/drivers/rtc/rtc-at91rm9200.c
>> @@ -37,9 +37,9 @@
>>  #include "rtc-at91rm9200.h"
>>  
>>  #define at91_rtc_read(field) \
>> -	__raw_readl(at91_rtc_regs + field)
>> +	readl_relaxed(at91_rtc_regs + field)
>>  #define at91_rtc_write(field, val) \
>> -	__raw_writel((val), at91_rtc_regs + field)
>> +	writel_relaxed((val), at91_rtc_regs + field)
> 
> I'm not against it but the SoC using it are Little only

It is used by the SAMA5D36 which is Cortex-A5 with big endian
support.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
