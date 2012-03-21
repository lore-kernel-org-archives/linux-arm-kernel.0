From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:46:34 +0100
Subject: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
In-Reply-To: <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
 <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
Message-ID: <4F69A37A.7020606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 10:41 AM, Shilimkar, Santosh wrote:
> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> The 'valid' field is never used in the code, let's remove it.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
> It is used during the registration. This field has been very useful for
> debug when need to disable a C-state etc.
> So unless and until there is a strong reason, i would like to retain it.

IMO if it used for debug purpose, it should be moved to the debug code 
and if the debug code is not upstream, then that 'valid' should not be 
here but in the out-of-tree code.

By the way, this may be a debate for nothing because a patchset is on 
the way to disable C-states from sysfs.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
