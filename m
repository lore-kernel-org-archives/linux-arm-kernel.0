From: ramana.gcc@googlemail.com (Ramana Radhakrishnan)
Date: Mon, 6 Aug 2018 09:04:33 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180805213615.GA1862@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <20180805213615.GA1862@amd>
Message-ID: <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2018 at 10:36 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
>> > strange problem.
>> >
>> > When I use the links browser in graphics mode on the framebuffer, I get
>> > occasional pixel corruption. Links does memcpy, memset and 4-byte writes
>> > on the framebuffer - nothing else.
>> >
>> > I found out that the pixel corruption is caused by overlapping unaligned
>> > stp instructions inside memcpy. In order to avoid branching, the arm64
>> > memcpy implementation may write the same destination twice with different
>> > alignment. If I put "dmb sy" between the overlapping stp instructions, the
>> > pixel corruption goes away.
>> >
>> > This seems like a hardware bug. Is it a known errata? Do you have any
>> > workarounds for it?
>>
>> Yes fix Links not to use memcpy on the framebuffer.
>> It is undefined behavior to use device memory with memcpy.
>
> No, I don't think so. Why do you think so?

It is undefined behaviour in the architecture.


Ramana
