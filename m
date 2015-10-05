From: lftan@altera.com (Ley Foon Tan)
Date: Mon, 5 Oct 2015 11:14:05 +0800
Subject: [PATCH v7 5/6] Documentation: dt-bindings: pci: altera pcie
 device tree binding
In-Reply-To: <6497772.rqSurELzER@wuerfel>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
 <CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
 <CAFiDJ5_MYC=V_L1LyRNq00z=DerzKAF=RF5av9vHnUPP+9a1nw@mail.gmail.com>
 <6497772.rqSurELzER@wuerfel>
Message-ID: <CAFiDJ590c0zG=bBBdERz9sh0Yvrrrv306Pd0simDmMWKw81z9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 3, 2015 at 5:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 02 October 2015 15:53:44 Ley Foon Tan wrote:
>> > Strictly speaking, if you have undocumented bindings downstream that
>> > is your problem and we don't have to accept them as-is upstream. I'm
>> > not going to worry about that here.
>> >
>> >>> txs contains the config space?
>> >> It is not the config space, but a memory slave port.
>> >
>> > Then where is the config space? It should not be part of "ranges" is
>> > all I care about.
>> The config space is not part of "ranges". Our IP uses TLP packet to
>> access config space.
>>
>
> It took me a bit to figure out what you mean here. To save others
> from reading the source, here is what I found:
>
> * The config space is accessed indirectly through registers from the
>   "cra" register range, which is the right approach according to the
>   point that Rob made.
You are right.

> * hardware-wise this basically looks like bit-banged PCIe, which is
>   both awesome and scary ;-)
