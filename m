From: arunks.linux@gmail.com (Arun KS)
Date: Fri, 16 Nov 2012 10:03:17 +0530
Subject: Decoding the PTM traces
In-Reply-To: <CAKZGPANSW9EEN6tRW7cPxDQkicKBWC9eK9A3dQSH1d61nXsHKQ@mail.gmail.com>
References: <CAKZGPAN-DEFD-X4az0O06ngjwdFAyrdowQ57QvtDpe8axZiwTg@mail.gmail.com>
 <CAMP5XgegGNn=NM8LEp61tZJWYQC3wbZ9mFz53cMsvPFr=bydaQ@mail.gmail.com>
 <CAKZGPANSW9EEN6tRW7cPxDQkicKBWC9eK9A3dQSH1d61nXsHKQ@mail.gmail.com>
Message-ID: <CAKZGPAP7AO-FpAqQfT+8mOcGHhNWo9d=H7e4XqTb2JzZzS_4Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arve,

On Thu, Nov 15, 2012 at 9:11 AM, Arun KS <arunks.linux@gmail.com> wrote:
> Hello Arve,
>
> On Thu, Nov 15, 2012 at 4:55 AM, Arve Hj?nnev?g <arve@android.com> wrote:
>> On Wed, Nov 14, 2012 at 6:04 AM, Arun KS <arunks.linux@gmail.com> wrote:
>>> Hello,
>>>
>>> I m trying to capture and decode PTM trace from Cortex A9 dual core.
>>>
>>> I m successful  in configuring the driver(arch/arm/kernel/etm.c) and
>>> setting the funnel to get data in ETB.
>>> But I don't know how to decode these traces.
>>>
>>> Anyone has any pointers?
>>>
>>> Thanks,
>>> Arun
>>
>> I attached some tools I use to decode the traces. I have used this on
>> the A8, A9 and A15. I assume since you cc-ed me you have already
>> applied the kernel patches I posted a while back. Without them you
>> will not get useful trace data from a dual core processor.
>
> Thank you very much for the tools. Hope I have taken all your patches.
>
> Here is how my git log --oneline looks on arch/arm/kernel/etm.c
>
> 75cbaea ARM: etm: Add sysfs entry to enable return stack if supported
> 434032a ARM: etm: Add sysfs entry to disable branch_output flag
> c6b1c35 ARM: etm: Add sysfs entry to set context-id-size
> cfb8dc5 ARM: etm: Add sysfs entry to enable timestamps if supported
> d263bc7 ARM: etm: Check arch version and disable data tracing for ptm
> eff62a8 ARM: etm: Wait for etm/ptm(s) to stop before requesting PowerDown
> 4246983 ARM: etm: Power down etm(s) when tracing is not enabled
> 992cd59 ARM: etm: Support multiple ETMs/PTMs.
> 3a91f3e ARM: etm: Return the entire trace buffer if it is empty after reset
> fe05bda ARM: etm: Add some missing locks and error checks
> 0c3da53 ARM: etm: Configure data tracing
> d71c695 ARM: etm: Allow range selection
> f13ae47 ARM: etm: Don't try to clear the buffer full status after
> reading the buffer
> 8511b5b ARM: etm: Don't limit tracing to only non-secure code.
> d387659 ARM: etm: Don't require clock control
> 73017a5 arm: fix implicit module.h users by adding it to arch/arm as required.
> 8e88069 ARM: 6838/1: etm: fix section mismatch warning
> aa25afa ARM: amba: make probe() functions take const id tables
> 092e0e7 Merge branch 'llseek' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/bkl
> 6038f37 llseek: automatically add .llseek fop
> 8234eae ARM: 6291/1: coresight: move struct tracectx inside etm driver
> 1495cc9 Input: sysrq - drop tty argument from sysrq ops handlers
> 988257c ARM: 6294/1: etm: do a dummy read from OSSRR during initialization
> 9e354ea ARM: 6292/1: coresight: add ETM management registers
> c5d6c77 ARM: 5841/1: a driver for on-chip ETM and ETB
>
> I ll let you know the results.

I m able to see decoded ptm traces using the following command,
python3.1 etm-objdump.py --trace-decoder=./etm
--trace-decoder-options="--pft-1.1 --sourceid-match 2" ptm.bin

Thanks,
Arun
>
> thanks,
> Arun
>>
>> --
>> Arve Hj?nnev?g
