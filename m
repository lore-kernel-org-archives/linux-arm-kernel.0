From: s-anna@ti.com (Suman Anna)
Date: Mon, 6 Aug 2018 20:39:44 -0500
Subject: New remoteproc driver for TI PRU
In-Reply-To: <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
 <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
 <536d28bd-bcdd-1665-e1c8-828572051cfb@ti.com>
 <5bd5e388-959c-cff7-df38-d267e06d4d96@lechnology.com>
Message-ID: <a377163f-e7a5-1f35-02ad-f223fc2c6e9d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 08/06/2018 11:32 AM, David Lechner wrote:
> On 06/29/2018 07:17 PM, Suman Anna wrote:
>> Hi David,
>>
>> On 06/29/2018 12:44 PM, David Lechner wrote:
>>> On 06/29/2018 04:58 AM, Roger Quadros wrote:
>>>> +Suman & Tero
>>>>
>>>> Hi David,
>>>>
>>>> On 24/06/18 00:08, David Lechner wrote:
>>>>>
>>>>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>>>>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>>>>
>>>>> This series adds a new remoteproc driver for the TI Programmable
>>>>> Runtime Unit
>>>>> (PRU) that is present in some TI Sitara processors. This code has
>>>>> been tested
>>>>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
>>>>
>>>> This is great. We have been working on something similar and I think
>>>> it would
>>>> be great if we can collaborate to get all our needs addressed.
>>>
>>> Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen
>>> the TI
>>> implementation. My primary interest is in the AM1808, which has a far
>>> simpler
>>> PRU than other SoCs. So, I was hoping I could get away with just
>>> implementing
>>> the basic stuff that I need and let TI add the more complex stuff later.
>>
>> Thanks for the series. PRUSS is present on many SoCs now, and each with
>> their own integration quirks, both in terms of SoC connections as well
>> as internal sub-modules within the subsystem. We currently support
>> AM335x, AM437x, AM57xx, Keystone 2 based 66AK2G and a newer generation
>> AM65x as well. It should be relatively straight-forward to scale this
>> for AM1808/OMAP-L138 as well. The move to the standard Common Clock and
>> Reset frameworks for clocks with the Davinci chips should make it
>> relatively straight-forward for the architecture pieces.
>>
>> I will take a look at your series in detail sometime next week, and
>> mostly post our series to the upstream lists as well within the next
>> couple of weeks so that it is easier for discussion on the upstream
>> lists.
>>
> 
> Have you had time to look at this yet? If you are too busy, I can submit
> a v2 with the interrupt controller broken out into a separate driver.

Yeah, I worked on it a bit around -rc4 time, but didn't get a chance to
complete the cleanup & testing before I had to shift to some other
tasks. If you are interested, I can share my branch. I will mostly get
back to this towards the latter half of next week. Anyway, I am
expecting 4.19-rc1 to be in a better shape w.r.t Davinci platform as the
genpd and CCF stuff comes in, and the pm_runtime usage for clocking in
my PRUSS drivers will fit well with those available.

regards
Suman
