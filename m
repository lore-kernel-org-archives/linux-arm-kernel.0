From: minggr@gmail.com (Lin Ming)
Date: Tue, 9 Jul 2013 16:21:49 +0800
Subject: kernel decompressor problem for ARMv7
In-Reply-To: <20130709080524.GB26169@mudshark.cambridge.arm.com>
References: <CAF1ivSakn8-HiAf+4_cLRWUUTDP9QBKpAt+hVQoMyAmKZ2-dJA@mail.gmail.com>
 <20130705095757.GA13063@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1307051225240.18597@syhkavp.arg>
 <CAF1ivSbOXknHyDMH3RdmSGK2n5o2wVeR5oohCQnZ2gJrgvo=Hw@mail.gmail.com>
 <1373250435.824.6.camel@minggr>
 <CAF1ivSbk70UnNc-09C2w-CdgaFBXe_k6K6n8Qr3L-jCLiTGqow@mail.gmail.com>
 <alpine.LFD.2.03.1307090837230.28525@syhkavp.arg>
 <CAF1ivSZK8c4zSz5E-=P4032jFJxFrmwHForbCjLTVcJs4xOWkg@mail.gmail.com>
 <20130709080524.GB26169@mudshark.cambridge.arm.com>
Message-ID: <CAF1ivSZxC=QtgK0k+5gpOWuVQjCf1W8j2mBoT11BQuatDgwnrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 9, 2013 at 4:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 09, 2013 at 08:53:05AM +0100, Lin Ming wrote:
>> On Tue, Jul 9, 2013 at 3:39 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > No more info needed.  The kernel has to be booted with the MMU disabled
>> > as per the booting protocol documentation. You therefore have to fix
>> > your
>> > bootloader.
>>
>> OK.
>>
>> But I have to also revert below commit to make decompressor work.
>>
>> commit 5010192:
>> ARM: 7583/1: decompressor: Enable unaligned memory access for v6 and above
>>
>> It seems like caused by bootloader has Alignment fault checking enabled.
>> Any suggestion how to fix it?
>
> Well step 1 is to disable the MMU. Once you've done that, you really don't
> want to be issuing unaligned accesses (since memory will be treated as
> strongly-ordered), so the value of the alignment trap bit is irrelevant.

Thanks. Will try it.

>
> Will
