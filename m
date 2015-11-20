From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 20 Nov 2015 08:58:36 -0700
Subject: [PATCH RFC 15/27] PM / Domains: Add next_wakeup to device's
 timing data
In-Reply-To: <7h8u5ttywi.fsf@deeprootsystems.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-16-git-send-email-lina.iyer@linaro.org>
 <7h8u5ttywi.fsf@deeprootsystems.com>
Message-ID: <20151120155836.GB30342@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19 2015 at 15:19 -0700, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Allow devices that know when their next wakeup event is, to record save
>> it as part of timing data. A genpd governor may use this data to
>> determine if suspending the domain is going to affect the QoS of its
>> devices.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  include/linux/pm_domain.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index f1329ea..9ac089d 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/of.h>
>>  #include <linux/notifier.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/ktime.h>
>>
>>  /* Defines used for the flags field in the struct generic_pm_domain */
>>  #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
>> @@ -104,6 +105,7 @@ struct gpd_timing_data {
>>  	s64 effective_constraint_ns;
>>  	bool constraint_changed;
>>  	bool cached_stop_ok;
>> +	ktime_t next_wakeup;
>>  };
>
>The addition of a new field should be combined with the patch that uses
>it (e.g. PATCH 16/27)
>
Okay. Will do.

>Kevin
