From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 12 Jan 2015 19:17:05 +0900
Subject: [PATCHv7 00/10] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
In-Reply-To: <437622256.904751421056684753.JavaMail.weblogic@epmlwas01a>
References: <437622256.904751421056684753.JavaMail.weblogic@epmlwas01a>
Message-ID: <54B39F21.3070602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 06:58 PM, MyungJoo Ham wrote:
>>   
>>  This patchset add new devfreq_event class to provide raw data to determine
>> current utilization of device  which is used for devfreq governor.
>>
>> The following description explains the feature of two kind of devfreq class:
>> - devfreq class (existing)
>>  : devfreq consumer device use raw data from devfreq_event device for
>>    determining proper current system state and change voltage/frequency
>>    dynamically using various governors.
>> - devfreq_event class (new)
>>  : Provide measured raw data to devfreq device for governor
>>
> 
> Question: Applying this patchset seems to imply that
> drivers/devfreq/exynos/exynos_ppmu.c becomes obsolete.
> How do you want to address it? Do you think it'd be ok to remove
> thse obsolete drivers after your successing patchset?
> 
> If it is ok to remove old drivers after applying the new patchset,
> please inclde a patch that removes old drivers unless such a removal
> might result in compatibility issues with old (yet another obsolete)
> board files, which I don't think probable.

I agree to remove 'drviers/devfreq/exynos/exynos_ppmu.c.
But, existing exynos_ppmu.c was used for drivers/devfreq/exynos/exynos5_bus.c.

Before removing existing 'exynos_ppmu.c', might need to test the devfreq-event class
on Exynos5260 SoC. I will just remove old driver('drivers/devfreq/exynos/exynos4_bus.{c|h}')
on next patchset.

To Abhilash,
Could you test this patch-set on Exynos5260 SoC?

Best Regards,
Chanwoo Choi
