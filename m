From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 21 Jun 2017 14:00:46 -0700
Subject: [PATCH v2 2/2] soc: brcmstb: Add driver for DPFE
In-Reply-To: <79cb33fc-cc6a-e79c-5e5c-af632e20dc76@gmail.com>
References: <20170613223710.31719-1-code@mmayer.net>
 <20170613223710.31719-3-code@mmayer.net>
 <5b79dee6-bb84-30b3-1bb2-287b24d42534@gmail.com>
 <CANEuBv6N3TTNzSuDQXk-eiEV_fvGtVJZhdWUO_XdgPj6+j7q5A@mail.gmail.com>
 <79cb33fc-cc6a-e79c-5e5c-af632e20dc76@gmail.com>
Message-ID: <a59aab64-b351-2e16-a5ab-b2ac41ffbf5e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 02:32 PM, Florian Fainelli wrote:
> On 06/14/2017 09:34 AM, Markus Mayer wrote:
>> On 13 June 2017 at 17:03, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> Hi Markus,
>>>
>>> On 06/13/2017 03:37 PM, Markus Mayer wrote:
>>>> From: Markus Mayer <mmayer@broadcom.com>
>>>>
>>>> This driver allows access to DRAM properties, such as the refresh rate,
>>>> via the Broadcom STB DDR PHY Front End (DPFE). The refresh rate can be
>>>> used as indirect indicator of the DRAM temperature.
>>>>
>>>> The driver also allows setting of the sampling interval.
>>>>
>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>>> ---
>>>>  MAINTAINERS                      |   8 +
>>>>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
>>>>  drivers/soc/bcm/brcmstb/dpfe.c   | 689 +++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 698 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/soc/bcm/brcmstb/dpfe.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index f7d568b..04f0be6 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2864,6 +2864,14 @@ S:     Maintained
>>>>  F:   Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
>>>>  F:   drivers/cpufreq/brcmstb*
>>>>
>>>> +BROADCOM STB SOC DPFE DRIVER
>>>> +M:   Markus Mayer <mmayer@broadcom.com>
>>>> +M:   bcm-kernel-feedback-list at broadcom.com
>>>> +L:   linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>> +S:   Maintained
>>>> +F:   Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt
>>>> +F:   drivers/misc/brcmstb-dpfe.c
>>>
>>> Just one nit: this should be drivers/soc/bcm/brcmstb/dpfe.c, other than
>>> that, I just need an Ack from Rob on the binding, and I will queue this
>>> up, thanks!
>>
>> Oops. Thanks for catching that. Would you like me to re-send or will
>> you fix up that path on your end?
> 
> I can fix it up if Rob is happy with the current binding, if you need to
> resubmit, please fix that as well. Thanks!

Can you respin a v2 with the MAINTAINERS file as well as the downstream
kernel fixes that implement suspend/resume support?

Thank you
> 


-- 
Florian
