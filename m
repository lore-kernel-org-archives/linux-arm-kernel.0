From: khilman@ti.com (Kevin Hilman)
Date: Thu, 17 May 2012 09:45:31 -0700
Subject: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG of
 IVAHD/TESLA
In-Reply-To: <CAMQu2gzNTjnYGcXzEOD0NVgbCT-nNwMf5A_LypLZCtXmwcKfwA@mail.gmail.com>
 (Santosh Shilimkar's message of "Thu, 17 May 2012 12:22:19 +0530")
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-11-git-send-email-t-kristo@ti.com>
 <87zk976827.fsf@ti.com>
 <CAMQu2gzNTjnYGcXzEOD0NVgbCT-nNwMf5A_LypLZCtXmwcKfwA@mail.gmail.com>
Message-ID: <871umi21uc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Thu, May 17, 2012 at 4:35 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> The ROM BUG is when MPU Domain OFF wake up sequence that can compromise
>>> IVA and Tesla execution.
>>>
>>> At wakeup from MPU OFF on HS device only (not GP device), when
>>> restoring the Secure RAM, the ROM Code reconfigures the clocks the
>>> same way it is done at Cold Reset.
>>
>> Ouch.
>>
>>> The IVAHD Clocks and Power Domain settings are:
>>> ? ? ? IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE = DISABLE
>>> ? ? ? IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE = DISABLE
>>> ? ? ? IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL = HW_AUTO
>>> ? ? ? IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE = OFF
>>> The TESLA Clocks and Power Domain settings are:
>>> ? ? ? TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE = DISABLE
>>> ? ? ? TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL = HW_AUTO
>>> ? ? ? TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE = OFF
>>>
>>> This patch fixes the low power OFF mode code so that the these
>>> registers are saved and restore across MPU OFF state.
>>>
>>> Also because of this limitation, MPU OFF alone is not targeted without
>>> device OFF to avoid IVAHD and TESLA execution impact
>>
>> I don't see where this restriction is implemented.
>>
> It's handled and the patch is in mainline for some time.
> We de-scoped MPU OFF from OMAP4430 devices in SW and
> hardware team de-scoped it in hardware from OMAP4460 onwards.
> Deepest state on MPUSS cluster is OSWR.

The question was about the changelog.

The changelog makes it sound like the restriction is part of the patch,
but it is not.  Please update the changlog to clarify that, ideally
adding a reference to the commit you mentioned.

Kevin
