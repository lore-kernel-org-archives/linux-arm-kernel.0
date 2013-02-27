From: anish198519851985@gmail.com (anish singh)
Date: Wed, 27 Feb 2013 18:28:07 +0530
Subject: How to measure the RAM read/write performance
In-Reply-To: <CAL7WMDc++dm0+2TxNbwwDB_xrqcLJWp2HTuTvqwrSXp3D-P2BA@mail.gmail.com>
References: <CAL7WMDcM9XommwO+rYJa5doMVXrFv1Vptu-s9cqaWfVXgx-qVg@mail.gmail.com>
 <CAK7N6vrptC7yOrH=boskNQD27PA-PqT9oPVgWe4Fagk95r4s=g@mail.gmail.com>
 <CAL7WMDc++dm0+2TxNbwwDB_xrqcLJWp2HTuTvqwrSXp3D-P2BA@mail.gmail.com>
Message-ID: <CAK7N6vqddKUbWTXGa3x4vY6S4iTXaEKbB_hK9bnGmebjudpbmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 6:16 PM, sandeep kumar
<coolsandyforyou@gmail.com> wrote:
>>Try below points:
>>1. I am not sure about snapdragon(is it Qualcomm?) but try
>>CONFIG_CPU_DCACHE_DISABLE.
> I did that already, device is not booting. In our architecture cache is
> tightly coupled with CPU.
Should be discussed with Qualcomm guys here as to the reason
why it doesn't boot up.
>
>>2. You are better off programming some DMA master to do large (and
>>uncached) reads/writes to RAM and timing that.
> DMA is not a standard way, i suppose, as it depends on what I/O peripheral
> we are doing the DMA.
You are doing I/O to RAM so it should do what you want.
CPU->DMA CONTROLLER->RAM
>
>>You should always add arm mailing list and please mention the chip set
>> details.
>>cat /proc/cpuinfo is a great way
> Processor       : ARMv7 Processor rev 2 (v7l)
> BogoMIPS        : 163.38
> Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls
> CPU implementer : 0x51
> CPU architecture: 7
> CPU variant     : 0x1
> CPU part        : 0x00f
> CPU revision    : 2
>
> Thanks
> Sandeep
>
>
>
>
> On Wed, Feb 27, 2013 at 5:37 PM, anish singh <anish198519851985@gmail.com>
> wrote:
>>
>> On Tue, Feb 26, 2013 at 5:01 PM, sandeep kumar
>> <coolsandyforyou@gmail.com> wrote:
>> > Hi All
>> > In performance benchmark tools, When we profile read/write timings
>> > mostly,
>> > those read/writes are done to cache only.
>> >
>> > I want to measure my DDR(RAM chip) performance.
>> > So i want to make sure, every read/write should happen to DDR RAM chip
>> > only.
>> Try below points:
>> 1. I am not sure about snapdragon(is it Qualcomm?) but try
>> CONFIG_CPU_DCACHE_DISABLE.
>> 2. You are better off programming some DMA master to do large (and
>> uncached) reads/writes to RAM and timing that.
>>
>> However simple uncached LDR/STR from the CPU may not be a great
>> measure of RAM controller perf.
>>
>> You should always add arm mailing list and please mention the chip set
>> details.
>> cat /proc/cpuinfo is a great way
>> >
>> > How can i achieve this...Any ideas/suggestions...?
>> >
>> > --
>> > With regards,
>> > Sandeep Kumar Anantapalli,
>> >
>> > _______________________________________________
>> > Kernelnewbies mailing list
>> > Kernelnewbies at kernelnewbies.org
>> > http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>> >
>
>
>
>
> --
> With regards,
> Sandeep Kumar Anantapalli,
