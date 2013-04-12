From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 12 Apr 2013 09:12:40 +0200
Subject: [PATCH 04/18] ARM: imx: cpuidle: create separate drivers for
 imx5/imx6
In-Reply-To: <20130412071124.GL16970@S2101-09.ap.freescale.net>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-5-git-send-email-daniel.lezcano@linaro.org>
 <20130412060527.GA16494@S2101-09.ap.freescale.net>
 <5167B0AC.2000308@linaro.org>
 <20130412071124.GL16970@S2101-09.ap.freescale.net>
Message-ID: <5167B3E8.2020007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 09:11 AM, Shawn Guo wrote:
> On Fri, Apr 12, 2013 at 08:58:52AM +0200, Daniel Lezcano wrote:
>> On 04/12/2013 08:05 AM, Shawn Guo wrote:
>>> On Wed, Apr 10, 2013 at 04:22:09PM +0200, Daniel Lezcano wrote:
>>>> The code intializes the cpuidle driver at different places.
>>>> The cpuidle driver for :
>>>>   * imx5 : is in the pm-imx5.c, the init function is in cpuidle.c
>>>>   * imx6 : is in cpuidle-imx6q.c, the init function is in cpuidle.c
>>>>            and cpuidle-imx6q.c
>>>>
>>>> Instead of having the cpuidle code spread across different files,
>>>> let's write a driver for each SoC and make the code similar.
>>>>
>>>> That implies some code duplication but that will be fixed with the
>>>> next patches which consolidate the initialization for all the drivers.
>>>>
>>> IMO, this is unnecessary churn.  I agree that we can have cpuidle-imx5.c
>>> instead of carrying imx5 cpuidle code in pm-imx5.c.  But removing
>>> cpuidle.c and duplicating what imx_cpuidle_init() does into imx5 and
>>> imx6q driver is a step backward to me.
>>> I suggest simply merging this patch into "[PATCH 18/18] ARM: imx:
>>> cpuidle: use init/exit common routine"
>>
>> Yes, I am aware that can can look weird but that was to have the
>> different steps to reach the common register function.
>> If I merge this patch with the patch 18, I am afraid the modification
>> won't be obvious to the one who will read the patch later (eg. for a git
>> bisect).
>>
>> It is quite easy to fold the patches, but with the comment above do you
>> still want me to do that ?
> 
> You can have a separate patch introducing cpuidle-imx5.c, but please do
> not duplicate what imx_cpuidle_init() does into cpuidle-imx5.c and
> cpuidle-imx6q.c.

Sure.

Thanks !

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
