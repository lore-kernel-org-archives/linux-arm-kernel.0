From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 29 Mar 2013 12:53:46 +0100
Subject: [PATCH 1/9] ARM: cpuidle: remove useless declaration
In-Reply-To: <51557DC6.5060104@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <51557DC6.5060104@ti.com>
Message-ID: <515580CA.30008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 12:40 PM, Santosh Shilimkar wrote:
> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>> The noop functions code is not necessary because the header file is
>> included in files which are compiled when CONFIG_CPU_IDLE is on.
>>
> Well the inline function was to avoid buid breaks when
> !CONFIG_CPU_IDLE.
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> Function without definition will break the build, No? Just
> declaration isn't won't help to get the build through.
> 
> Ofcourse if all idle drivers are build *only when*
> CONFIG_CPU_IDLE=y, then the patch is should
> be fine.

Yes, it is case AFAICT.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
