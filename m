From: jean.pihet@linaro.org (Jean Pihet)
Date: Tue, 6 May 2014 19:41:55 +0200
Subject: [PATCH 3/3] perf tools: Add libdw DWARF post unwind support for
 ARM64
In-Reply-To: <20140506170039.GB13677@arm.com>
References: <1399391733-11927-1-git-send-email-jean.pihet@linaro.org>
 <1399391733-11927-4-git-send-email-jean.pihet@linaro.org>
 <20140506170039.GB13677@arm.com>
Message-ID: <CAFrcx1n923=fw6L=OnrDbRhWc9WGTc-FWRFeDCVtnJjKaPwyDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 6 May 2014 19:00, Will Deacon <will.deacon@arm.com> wrote:
> Hi Jean,
>
> On Tue, May 06, 2014 at 04:55:33PM +0100, Jean Pihet wrote:
>> Adding libdw DWARF post unwind support, which is part
>> of elfutils-devel/libdw-dev package from version 0.158.
>>
>> Note: the libdw code needs some support for dwarf unwinding
>> on ARM64, this code is submitted seperately on the elfutils
>> ML.
>>
>> The new code is contained in unwin-libdw.c object, and
>> implements unwind__get_entries unwind interface function.
>
> Are you planning to implement support for 32-bit ARM too? If so, we'll need
> compat handling here again (your favourite!).
Yes! Another patch set (sent just before this one) targets ARM. There
is a nice ToDo in the cover letter: handle compat mode correctly. In
fact I sent a patch to libdw, so it supports it already but is
somewhat broken for compat mode. This is on my prefered ToDo list ;-)

>
>> +bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>> +{
>> +     struct unwind_info *ui = arg;
>> +     struct regs_dump *user_regs = &ui->sample->user_regs;
>> +     Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX];
>
> Shouldn't this be PERF_REG_ARM64_MAX - 1?
Ah, well spotted! I will change although it shouldn't harm, right?

>
> Will

Thx for reviewing,
Jean
