From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 11 Jan 2016 10:18:46 +0000
Subject: [PATCH 05/10] arm64: dts: r8a7795: Add pmu device nodes
In-Reply-To: <5690AA7A.4000303@gmail.com>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
 <a6b6b478459be0c5614626ba6ac95df05a7fc5e9.1450401186.git.horms+renesas@verge.net.au>
 <5673DCF7.1050008@arm.com> <5673E39C.6050206@gmail.com>
 <5673E437.7020300@arm.com> <5690AA7A.4000303@gmail.com>
Message-ID: <56938186.3010202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/01/16 06:36, Dirk Behme wrote:
> On 18.12.2015 11:47, Sudeep Holla wrote:
>>
>>
>> On 18/12/15 10:44, Dirk Behme wrote:
>>> On 18.12.2015 11:16, Sudeep Holla wrote:

[...]

>>>>
>>>> Please use arm,cortex-a57-pmu to be more specific. IIRC I mentioned
>>>> this for some shmobile platform recently.
>>>
>>> Yes. But as this patch has been applied already to some branches, I
>>> incorporated your a57-pmu hint with an additional update patch:
>>>
>>> http://marc.info/?l=linux-sh&m=145011467914857
>>>
>>> Feel free to squash if still possible.
>>>
>>
>> Ah OK, I didn't know the exact dts name, sorry for the noise.
>> Better if it was posted as part of this series :)
>
>
> I finally found some time to test this
>
> http://marc.info/?l=linux-sh&m=145011467914857
>
> and surprisingly it doesn't seem to work:
>
> Using "arm,cortex-a57-pmu" results in
>
> hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7 counters available

I had a quick look at the DT in the link above and IIUC A57 PMU's are
successfully probed.

> hw perfevents: failed to probe PMU!
> hw perfevents: failed to register PMU devices!
>

This must be for A53 PMUs. So I suspect if the update DT is passed
correctly to the kernel.

> while switching back to "arm,armv8-pmuv3" successfully gives
>
> hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
>
> without any further error messages.
>
> Any idea?

You need to check if of_pmu_irq_cfg is failing.
Is the updated DT picked up correctly ?

-- 
Regards,
Sudeep
