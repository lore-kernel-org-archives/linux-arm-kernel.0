From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Nov 2016 10:13:43 +0100
Subject: [PATCH v3 0/3] modversions: Fix CRC mangling under
 CONFIG_RELOCATABLE=y
In-Reply-To: <87eg2kj757.fsf@concordia.ellerman.id.au>
References: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu8Yc9rUacE70mvZSR92g1OY6LYyN6zrd--omwZVqwg3TA@mail.gmail.com>
 <87eg2kj757.fsf@concordia.ellerman.id.au>
Message-ID: <CAKv+Gu_Ej5j8MTQkzhw3Kyzkk4mENuBm12NoLU-aaw_R_OW_yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 November 2016 at 05:22, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>
>> On 27 October 2016 at 17:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> This series is a followup to the single patch 'modversions: treat symbol
>>> CRCs as 32 bit quantities on 64 bit archs', of which two versions have
>>> been sent out so far [0][1]
>>>
>>> As pointed out by Michael, GNU ld behaves a bit differently between arm64
>>> and PowerPC64, and where the former gets rid of all runtime relocations
>>> related to CRCs, the latter is not as easily convinced.
>>>
>>> Patch #1 fixes the issue where CRCs are corrupted by the runtime relocation
>>> routines for 32-bit PowerPC, for which the original fix was effectively
>>> reverted by commit 0e0ed6406e61 ("powerpc/modules: Module CRC relocation fix
>>> causes perf issues")
>>>
>>> Patch #2 adds handling of R_PPC64_ADDR32 relocations against the NULL .dynsym
>>> symbol entry to the PPC64 runtime relocation routines, so it is prepared to
>>> deal with CRCs being emitted as 32-bit quantities.
>>>
>>> Patch #3 is the original patch from the v1 and v2 submissions.
>>>
>>> Changes since v2:
>>> - added #1 and #2
>>> - updated #3 to deal with CRC entries being emitted from assembler
>>> - added Rusty's ack (#3)
>>>
>>> Branch can be found here:
>>> https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git/log/?h=kcrctab-reloc
>>>
>>> [0] http://marc.info/?l=linux-kernel&m=147652300207369&w=2
>>> [1] http://marc.info/?l=linux-kernel&m=147695629614409&w=2
>>
>> Ping?
>
> Sorry, you didn't cc linuxppc-dev, so it's not in my patchwork list
> which tends to mean I miss it.
>

Ah, my mistake. Apologies.

> Will try and test and get back to you.
>

Thanks!
