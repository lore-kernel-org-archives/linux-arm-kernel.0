From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 17 Mar 2012 09:12:11 +0000
Subject: [PATCH] drivers/base: fix compiler warning in SoC export driver
 - idr should be ida
In-Reply-To: <20120317090424.GK15988@n2100.arm.linux.org.uk>
References: <4F6452D6.30307@linaro.org>
 <20120317090424.GK15988@n2100.arm.linux.org.uk>
Message-ID: <4F64556B.3010505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/12 09:04, Russell King - ARM Linux wrote:
> On Sat, Mar 17, 2012 at 09:01:10AM +0000, Lee Jones wrote:
> 
> If you're fixing a warning, please always include the warning in the
> commit description.

No problem, thanks.

>> Reported-by: Arnd Bergman <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  drivers/base/soc.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
>> index 05f1503..e57aec1 100644
>> --- a/drivers/base/soc.c
>> +++ b/drivers/base/soc.c
>> @@ -15,7 +15,7 @@
>>  #include <linux/sys_soc.h>
>>  #include <linux/err.h>
>>  
>> -static DEFINE_IDR(soc_ida);
>> +static DEFINE_IDA(soc_ida);
>>  static DEFINE_SPINLOCK(soc_lock);
>>  
>>  static ssize_t soc_info_get(struct device *dev,
>> -- 
>> 1.7.5.4
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
