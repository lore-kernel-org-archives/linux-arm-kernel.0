From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Oct 2017 15:09:35 +0100
Subject: [PATCH v2] arm64: dts: foundation-v8: Enable PSCI mode
In-Reply-To: <8c4a4114-b7f7-301e-20b8-960e6234b661@linaro.org>
References: <20170918153832.16356-1-daniel.thompson@linaro.org>
 <20170919183204.12751-1-daniel.thompson@linaro.org>
 <da8a0cf5-3c1e-1398-b5c3-ac489ae955fa@arm.com>
 <9a542b9a-3c37-ed8a-04e6-de41493f4b0d@linaro.org>
 <e49177f9-a9a8-e322-3743-5c58277c46ea@arm.com>
 <8c4a4114-b7f7-301e-20b8-960e6234b661@linaro.org>
Message-ID: <521d6f60-ee90-bc96-97a7-1da33170a9c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/17 10:12, Daniel Thompson wrote:
> On 02/10/17 18:26, Sudeep Holla wrote:
>> Sorry for late response, I thought I had sent this mail out long back
>> but was sitting in my draft :(
> 
> No worries. I've been at Linaro connect this last week anyway.
> 
> 
>> On 20/09/17 12:17, Daniel Thompson wrote:
>>> On 20/09/17 10:42, Sudeep Holla wrote:
>>>>
>>>>
>>>> On 19/09/17 19:32, Daniel Thompson wrote:
>>>>> Currently if the Foundation model is running ARM Trusted Firmware then
>>>>> the kernel, which is configured to use spin tables, cannot start
>>>>> secondary
>>>>> processors or "power off" the simulation.
>>>>>
>>>>> After adding a couple of labels to the include file and splitting out
>>>>> the
>>>>> spin-table configuration into a header, we add a couple of new headers
>>>>> together with two new DTs (GICv2+PSCI and GICv3+PSCI).
>>>>>
>>>>> The new GICv3+PSCI DT has been boot tested, the remaining three
>>>>> (two of
>>>>> which existed prior to this patch) have been "tested" by
>>>>> decompiling the
>>>>> blobs and comparing them against a reference.
>>>>>
>>>>
>>>> How different are these from the ones hosted in [1] ?
>>>
>>> They look like they were either independently written or diverged a long
>>> time ago. The existing kernel DTs describe hardware absent from the ARM
>>> TF ones and vice versa.
>>>
>>
>> OK.
>>
>>> With specific reference to PSCI it looks like my patches could perhaps
>>> be improved by adding idle-state support.
>>
>> Yes I know.
> 
> You want a v3 with it added?
> 

No, that's fine. I have pushed this already [1] with Mark's ack for now.
We can add it later after some testing, not urgent.

--
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-next/juno
