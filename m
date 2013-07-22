From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 22 Jul 2013 06:32:01 +0200
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <1374467085.15946.16.camel@jlo-ubuntu-64.nvidia.com>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
 <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
 <51E5A438.10004@wwwdotorg.org>
 <1374056130.10997.16.camel@jlo-ubuntu-64.nvidia.com>
 <51E6FF0B.5000708@wwwdotorg.org>
 <1374145726.5610.73.camel@jlo-ubuntu-64.nvidia.com>
 <51E7E27B.9090605@linaro.org>
 <1374218064.24607.1.camel@jlo-ubuntu-64.nvidia.com>
 <51E91A72.6070708@linaro.org>
 <1374462916.15946.14.camel@jlo-ubuntu-64.nvidia.com>
 <51ECB223.5000002@linaro.org>
 <1374467085.15946.16.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51ECB5C1.600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 06:24 AM, Joseph Lo wrote:
> On Mon, 2013-07-22 at 12:16 +0800, Daniel Lezcano wrote:
>> On 07/22/2013 05:15 AM, Joseph Lo wrote:
>>> On Fri, 2013-07-19 at 18:52 +0800, Daniel Lezcano wrote:
>>>> On 07/19/2013 09:14 AM, Joseph Lo wrote:
>>>>> On Thu, 2013-07-18 at 20:41 +0800, Daniel Lezcano wrote:
>>>>>> On 07/18/2013 01:08 PM, Joseph Lo wrote:
>>>>>>> On Thu, 2013-07-18 at 04:31 +0800, Stephen Warren wrote:
>>>>>>>> On 07/17/2013 04:15 AM, Joseph Lo wrote:
>>>>>>>>> On Wed, 2013-07-17 at 03:51 +0800, Stephen Warren wrote:
>>>>>>>>>> On 07/16/2013 05:17 AM, Joseph Lo wrote:
>>>>>>>>>>> On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
>>>>>>>>>>>> On 06/25/2013 03:23 AM, Joseph Lo wrote:
>>>>>>>>>>>>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
>>>>>>>>>>>>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
>>>>>>>>>>>>> this state.
>>>>>>>> ... [ discussion of issues with Joesph's patches applied]
>>>>>>>>>
> [...]
>>>>
>>>> Ok, so the problem occurs with the CPUIDLE_FLAG_TIMER_STOP flag only on
>>>> tegra114, right ?
>>>>
>>>> Sorry, I am a bit lost :)
>>>>
>>> Here are the issues that happen after apply CPUIDLE_FLAG_TIMER_STOP.
>>> 1) Tegra114/30
>>> The warning message at kernel/time/tick-broadcast.c:667
>>> tick_broadcast_oneshot_control could be triggered when doing CPU hot
>>> plug stress test.
>>
>> With the fix for tick-broadcast.c [1] ?
> Yes.
> 
>>
>>> 2) Tegra20
>>> The system is easy to stick or become lag.
>>> The CPU hot plug is easy to cause system stick too.
>>>
>>> The fix I suggested in another mail looks can fix all the issues above.
>>> I verified it again today on 3 different Tegra SoC platforms.
>>
>> Not sure your patch fixes the problem.
>>
>> I am wondering if there isn't a underlaying problem which surface with
>> the flag.

Does the attached patch changes something ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0011-cpuidle-add-hotplug-support-to-initialize-the-timer-.patch
Type: text/x-diff
Size: 3462 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130722/66dbbf3f/attachment.bin>
