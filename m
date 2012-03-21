From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 21 Mar 2012 15:33:14 +0530
Subject: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
In-Reply-To: <4F69A37A.7020606@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
 <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
 <4F69A37A.7020606@linaro.org>
Message-ID: <4F69A762.5070006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 March 2012 03:16 PM, Daniel Lezcano wrote:
> On 03/21/2012 10:41 AM, Shilimkar, Santosh wrote:
>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org>  wrote:
>>> The 'valid' field is never used in the code, let's remove it.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>> ---
>> It is used during the registration. This field has been very useful for
>> debug when need to disable a C-state etc.
>> So unless and until there is a strong reason, i would like to retain it.
> 
> IMO if it used for debug purpose, it should be moved to the debug code
> and if the debug code is not upstream, then that 'valid' should not be
> here but in the out-of-tree code.
>
When I said debug, I mean CPUIDLE debug and not any special debug code.

> By the way, this may be a debate for nothing because a patchset is on
> the way to disable C-states from sysfs.
> 
I see but sysfs won't solve that because you want to disable certain
C-state so that CPUIDLE driver don't use that state.

Let say if the C4 which is OSWR is broken. In such cases, just
setting valid flag let you disable it.

Again I don't have strong objection to this change.

Regards
santosh
