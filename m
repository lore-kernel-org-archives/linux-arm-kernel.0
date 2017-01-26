From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Wed, 25 Jan 2017 18:16:11 -0800
Subject: [PATCH] perf: xgene: Include module.h
In-Reply-To: <CACgAJHzQtnLnNamP28Sq_PENU8s7hWYiXLoCbLMLx9-0rU_bwA@mail.gmail.com>
References: <20170125234658.12071-1-sboyd@codeaurora.org>
 <CACgAJHzQtnLnNamP28Sq_PENU8s7hWYiXLoCbLMLx9-0rU_bwA@mail.gmail.com>
Message-ID: <CACgAJHyTx2=Z03dnL8ixUpqMncpX=-7chQ_+62L_OD6=81Qj9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My bad, I can reproduce the issue now.

Thanks
Tai

On Wed, Jan 25, 2017 at 6:13 PM, Tai Tri Nguyen <ttnguyen@apm.com> wrote:
> Hi Stephen,
>
> On Wed, Jan 25, 2017 at 3:46 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> I ran into a build error when I disabled CONFIG_ACPI and tried to
>> compile this driver:
>
> I tried kernel 4.9 and couldn't reproduce the issue.
> What is the kernel version you are seeing the compilation issue?
>
> Regards
> Tai
>
>>
>> drivers/perf/xgene_pmu.c:1242:1: warning: data definition has no type or storage class
>>  MODULE_DEVICE_TABLE(of, xgene_pmu_of_match);
>>  ^
>> drivers/perf/xgene_pmu.c:1242:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
>>
>> Include module.h for the MODULE_DEVICE_TABLE macro that's
>> implicitly included through ACPI.
>>
>> Cc: Tai Nguyen <ttnguyen@apm.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/perf/xgene_pmu.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
>> index a8ac4bcef2c0..fb3281962a6d 100644
>> --- a/drivers/perf/xgene_pmu.c
>> +++ b/drivers/perf/xgene_pmu.c
>> @@ -20,6 +20,7 @@
>>   */
>>
>>  #include <linux/acpi.h>
>> +#include <linux/module.h>
>>  #include <linux/clk.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/interrupt.h>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>
>
>
> --
> Tai



-- 
Tai
