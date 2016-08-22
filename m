From: nitinchaudhary1289@gmail.com (Nitin Chaudhary)
Date: Sun, 21 Aug 2016 21:05:00 -0700
Subject: [PATCH 1/3] Error: Fix mmdc compilation errors due to cpu notifier
In-Reply-To: <DB5PR04MB14300BA6980837ED811FE6C19F160@DB5PR04MB1430.eurprd04.prod.outlook.com>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <1471570860-2087-1-git-send-email-Nitin.Chaudhary@zii.aero>
 <1471570860-2087-2-git-send-email-Nitin.Chaudhary@zii.aero>
 <DB5PR04MB14300BA6980837ED811FE6C19F160@DB5PR04MB1430.eurprd04.prod.outlook.com>
Message-ID: <CAJOu_29XnPaNAoX9xh9=nMmyn=s8r8srDfZiEauDhJHT2+QmAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhengyu,

I understood what you are trying to say here. I also saw your latest
code which you posted on LKML and that made it all clear. Thanks for
your help and guidance.

On Fri, Aug 19, 2016 at 8:28 AM, Zhengyu Shen <zhengyu.shen@nxp.com> wrote:
>> Subject: [PATCH 1/3] Error: Fix mmdc compilation errors due to cpu notifier
>>
>> ---
>>  arch/arm/mach-imx/mmdc.c   | 89 ++++++++++++++++++++++---------------
>> ---------
>>  include/linux/cpuhotplug.h |  1 +
>>  2 files changed, 44 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
>> index 372b59c..95c222d 100644
>> --- a/arch/arm/mach-imx/mmdc.c
>> +++ b/arch/arm/mach-imx/mmdc.c
>> @@ -77,13 +77,14 @@ struct mmdc_pmu
>>         struct pmu pmu;
>>         void __iomem *mmdc_base;
>>         cpumask_t cpu;
>> -       struct notifier_block cpu_nb;
>>         struct hrtimer hrtimer;
>>         unsigned int irq;
>>         struct device *dev;
>>         struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];  };
>>
>> +static struct mmdc_pmu *pmu_mmdc;
>> +
> I'm not sure it's a good idea to make the pmu static. I looked at several
> other drivers for perf and most of them didn't have the pmu wrapper
> as a static variable. Almost every other file which involves pmus uses
> the container_of macro to get the pmu wrapper from the event.
> I also looked over some documentation and some internal code and there
> are two MMDCs on i.MX6 Quad although one appears to be unused.
> I think just to be on the safe side it should not be made static.



-- 
Thanks & Regards

Nitin Chaudhary
MS, Electrical Engineering
University of Southern California
Intern, Zodiac In-flight Innovations
