From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 4 Oct 2016 13:51:21 +0100
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <CAGhh56HHbpLAmsu0z9xMPgq9m0qGBHdr6Kj2xw3vhNYu+fUONA@mail.gmail.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
 <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
 <cc531f08-d09b-1976-90c2-377a5878b1eb@arm.com>
 <CAGhh56HHbpLAmsu0z9xMPgq9m0qGBHdr6Kj2xw3vhNYu+fUONA@mail.gmail.com>
Message-ID: <c1d2b846-cb8f-470b-106f-f8063639ef92@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/16 13:14, Venkatesh Vivekanandan wrote:
> On Tue, Oct 4, 2016 at 4:00 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 04/10/16 06:37, Venkatesh Vivekanandan wrote:
>>>
>>> On Mon, Oct 3, 2016 at 6:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>
>>>> Hi Venkatesh,
>>>>
>>>> On 03/10/16 12:36, Venkatesh Vivekanandan wrote:
>>>>>
>>>>>
>>>>> Hi All,
>>>>>
>>>>> I am trying to collect ETF trace from Juno R1 and could see "cpu
>>>>> stall" while dumping the trace. Attached is the log of sequence
>>>>> followed. Was trying to collect the trace data from hardware and see
>>>>> if it is any valid data. Am I missing anything here?.
>>>>>
>>>>
>>>> There are few fixes from me and Suzuki queued for v4.9.
>>>> Can you check if this issue persists even on linux-next ?
>>>
>>>
>>> Issue is the same in linux-next as well. Please find the attached log.
>>>
>>
>> OK, what do you mean by the issue still being present. I no longer see
>> any ETM failures or messages. Does the system hang when you try to read
>> /dev/<addr>.etf ?
> Yes, system hangs while reading /dev/<addr>.etf. Most of the times, it
> gives RCU stall and sometimes just hangs and I have to reboot in both
> case.

OK, I am unable reproduce the issue hence suspecting the firmware to be
very old.

>>
>> Also the RCU stalls could be related to CPUIdle. Are you using latest
>> versions of trusted firmware ?
> Firmware is the one that came along with the board. Didn't update to
> anything latest.
>
> From bootlog,
>
> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
> [    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.50 by ARM Juno EFI Nov 24 2015 17:54:31
> [    0.000000] efi:  ACPI=0xfe720000  ACPI 2.0=0xfe720014  PROP=0xfe773f30
>

No, I was referring to the ones very early in the boot, something like:

NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.2(release):a5a423100822
NOTICE:  BL1: Built : 11:42:57, Sep 30 2016
NOTICE:  BL1: Booting BL2
NOTICE:  BL2: v1.2(release):a5a423100822
NOTICE:  BL2: Built : 11:42:58, Sep 30 2016
NOTICE:  BL1: Booting BL31
NOTICE:  BL31: v1.2(release):a5a423100822
NOTICE:  BL31: Built : 11:43:06, Sep 30 2016
UEFI firmware (version  built at 11:42:39 on Sep 30 2016)

Ignore the dates here as I have build one last week.

> Please let me know, if the firmware needs to be updated to specific
> version. Any pointers on that would be appreciated.
>

Yes always better as they will have bug fixes. You can get one from [1] 
or just follow instructions @[2].

[1] 
http://snapshots.linaro.org/member-builds/armlt-platforms-release/32/juno-uefi.zip 

[2] https://community.arm.com/docs/DOC-11395

-- 
Regards,
Sudeep
