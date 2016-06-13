From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 13 Jun 2016 15:53:47 +0100
Subject: [PATCH 1/3] arm64: dts: juno: add coresight support
In-Reply-To: <CANLsYkzSOrypAZaDYAvvaFBB50ugkOpGFKCh-Sd=EyCE8bG0gg@mail.gmail.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-2-git-send-email-sudeep.holla@arm.com>
 <CANLsYkzbtW2nFsntQ8vLafu=JS+qcjXm+6HQpi3F_P2a5CsHaw@mail.gmail.com>
 <575E7A56.6070005@arm.com>
 <CANLsYkzSOrypAZaDYAvvaFBB50ugkOpGFKCh-Sd=EyCE8bG0gg@mail.gmail.com>
Message-ID: <575EC8FB.40309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/06/16 15:47, Mathieu Poirier wrote:
> On 13 June 2016 at 03:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 12/06/16 22:57, Mathieu Poirier wrote:
>>>
>>> On 6 June 2016 at 09:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>
>>>> Most of the debug-related components on Juno are located in the coreSight
>>>> subsystem while others are located in the Cortex-Axx clusters, the SCP
>>>> subsystem, and in the main system.
>>>>
>>>> Each core in the two processor clusters contain an Embedded Trace
>>>> Macrocell(ETM) which generates real-time trace information that trace
>>>> tools can use and an ATB trace output that is sent to a funnel before
>>>> going to the CoreSight subsystem.
>>>>
>>>> The trace output signals combine with two trace expansions using another
>>>> funnel and fed into the Embedded Trace FIFO(ETF0).
>>>>
>>>> The output trace data stream of the funnel is then replicated before it
>>>> is sent to either the:
>>>> - Trace Port Interface Unit(TPIU), that sends it out using the trace
>>>> port.
>>>> - ETR that can write the trace data to memory located in the application
>>>>     memory space
>>>
>>>
>>> Hi Sudeep,
>>>
>>> Did you try booting this on juno-r0?  On my side the system won't boot
>>> unless I enable the debug power domain by externally connecting to the
>>> system using DS-5.
>>>
>>
>> As you have already realized that you need SCPI power domain patches for
>> the functionality. However, in absence of those patches or when it's
>> disabled, it shouldn't cause any boot or runtime issues. Only ETM or
>> coresight won't work. If it's causing any crash or hang, please do let
>> me know, that needs to be fixed. I have only tested with latest
>> firmware. Let me know the details of hang/crash and firmware version you
>> are using.
>
> We have a problem then.  Booting with this branch[1] and the 3 DT
> patches from this set the system hangs.  But before going any further
> I'd bet the FW on my board is too old.  This is what I get on my side:
>
> RM V2M-Juno Boot loader v1.0.0
> HBI0262 build 1684
>
> ARM V2M_Juno Firmware v1.3.4
> Build Date: Aug 27 2015
>

Yes looks old *but* these are motherboard firmware, while I was
interested in SCP firmware. Anyways can you provide more details on the
hang (where/what/...)? Also the boot log(what ever you are getting out
if any)

-- 
Regards,
Sudeep
