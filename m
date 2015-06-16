From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 17 Jun 2015 00:04:07 +0200
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
In-Reply-To: <20150616214032.GA4313@saruman.tx.rr.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
 <20150616214032.GA4313@saruman.tx.rr.com>
Message-ID: <CAJZ5v0hO+Rbcyq8Gcpecdw9rGW1Qdhrmj6X6TVtRpLOxQKW+=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:40 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, May 08, 2015 at 02:57:30PM -0500, Felipe Balbi wrote:
>> by adding the missing MODULE_ALIAS(), cpufreq-dt
>> can be autoloaded by udev/systemd.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> looks like this wasn't applied anywhere. Viresh, can you apply this
> patch please ?

I've overlooked it, sorry about that.  Applied now, thanks!


>> ---
>>  drivers/cpufreq/cpufreq-dt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index bab67db54b7e..528a82bf5038 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -416,6 +416,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
>>  };
>>  module_platform_driver(dt_cpufreq_platdrv);
>>
>> +MODULE_ALIAS("platform:cpufreq-dt");
>>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>>  MODULE_DESCRIPTION("Generic cpufreq driver");
>> --
>> 2.4.0.rc3
>>
>
> --
> balbi
