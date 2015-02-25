From: al.stone@linaro.org (Al Stone)
Date: Wed, 25 Feb 2015 13:56:04 -0700
Subject: [PATCH v3 2/9] ACPI: clear up warnings on use of printk reported
 by checkpatch.pl
In-Reply-To: <54EDC64D.8040301@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org>
 <1424824585-6405-3-git-send-email-al.stone@linaro.org>
 <54EDC64D.8040301@linaro.org>
Message-ID: <54EE36E4.5070404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2015 05:55 AM, Hanjun Guo wrote:
> On 2015?02?25? 08:36, al.stone at linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> In preparation for later splitting out some of the arch-dependent code from
>> osl.c, clear up all the warnings reported by checkpatch.pl where pr_* should
>> be used instead of printk(KERN_* ...).
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/osl.c | 46 +++++++++++++++++++---------------------------
>>   1 file changed, 19 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 1dc3a3b..865317c 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -141,7 +141,7 @@ static u32 acpi_osi_handler(acpi_string interface, u32
>> supported)
>>   {
>>       if (!strcmp("Linux", interface)) {
>>
>> -        printk_once(KERN_NOTICE FW_BUG PREFIX
>> +        pr_notice_once(FW_BUG PREFIX
> 
> I think you can use pr_fmt() and then remove all the PREFIX in
> this patch, just
> 
> #define pr_fmt(fmt) "ACPI: " fmt
> 
> in top of this file before all #includes.
> 
> Thanks
> Hanjun

Argh.  Yup, you're right.  That was an oversight on my part.
Fixed in next version.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
