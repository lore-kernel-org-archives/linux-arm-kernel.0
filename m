From: venkatesh.vivekanandan@broadcom.com (Venkatesh Vivekanandan)
Date: Tue, 4 Oct 2016 17:44:49 +0530
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <cc531f08-d09b-1976-90c2-377a5878b1eb@arm.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
 <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
 <cc531f08-d09b-1976-90c2-377a5878b1eb@arm.com>
Message-ID: <CAGhh56HHbpLAmsu0z9xMPgq9m0qGBHdr6Kj2xw3vhNYu+fUONA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 4, 2016 at 4:00 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 04/10/16 06:37, Venkatesh Vivekanandan wrote:
>>
>> On Mon, Oct 3, 2016 at 6:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> Hi Venkatesh,
>>>
>>> On 03/10/16 12:36, Venkatesh Vivekanandan wrote:
>>>>
>>>>
>>>> Hi All,
>>>>
>>>> I am trying to collect ETF trace from Juno R1 and could see "cpu
>>>> stall" while dumping the trace. Attached is the log of sequence
>>>> followed. Was trying to collect the trace data from hardware and see
>>>> if it is any valid data. Am I missing anything here?.
>>>>
>>>
>>> There are few fixes from me and Suzuki queued for v4.9.
>>> Can you check if this issue persists even on linux-next ?
>>
>>
>> Issue is the same in linux-next as well. Please find the attached log.
>>
>
> OK, what do you mean by the issue still being present. I no longer see
> any ETM failures or messages. Does the system hang when you try to read
> /dev/<addr>.etf ?
Yes, system hangs while reading /dev/<addr>.etf. Most of the times, it
gives RCU stall and sometimes just hangs and I have to reboot in both
case.
>
> Also the RCU stalls could be related to CPUIdle. Are you using latest
> versions of trusted firmware ?
Firmware is the one that came along with the board. Didn't update to
anything latest.

>From bootlog,

[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.50 by ARM Juno EFI Nov 24 2015 17:54:31
[    0.000000] efi:  ACPI=0xfe720000  ACPI 2.0=0xfe720014  PROP=0xfe773f30

Please let me know, if the firmware needs to be updated to specific
version. Any pointers on that would be appreciated.

>
> --
> Regards,
> Sudeep
