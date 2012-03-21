From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 21 Mar 2012 14:43:58 +0100
Subject: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
In-Reply-To: <4F69A872.50203@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <4F69A872.50203@ti.com>
Message-ID: <CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Daniel,
>
> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>> This patchset is a proposition to improve a bit the code.
>> The changes are code cleanup and does not change the behavior of the
>> driver itself.
>>
>> A couple a things call my intention. Why the cpuidle device is set for cpu0 only
>> and why the WFI is not used ?
>>
>> Daniel Lezcano (7):
>> ? ARM: OMAP4: cpuidle - Remove unused valid field
>> ? ARM: OMAP4: cpuidle - Declare the states with the driver declaration
>> ? ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>> ? ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>> ? ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
>> ? ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>> ? ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
>> ? ? time
>>
> The series looks fine to me in general. This clean-up is applicable
> for OMAP3 cpuidle code as well.
Great!
However OMAP3 has a few specific things that cannot be removed as easily:
- the 'valid' flag is used because only certain combinations of power
domains states are possible,
- the latency settings can be overriden by the board code, so the
cpuidle_params struct is needed.

> I want Jean to look at this series because some of his earlier
> clean up has introduced those custom functions which
> are getting removed in this series.
>
> Regards
> santosh
>
>

Thanks,
Jean
