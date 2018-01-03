From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 03 Jan 2018 17:24:02 +1100
Subject: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
In-Reply-To: <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au>
 <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
Message-ID: <87h8s3cvel.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> We want to use the dma_direct_ namespace for a generic implementation,
>>> so rename powerpc to the second best choice: dma_nommu_.
>>
>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>> than mapping dynamically.
>>
>> Though I don't have a good idea for a better name, maybe "1to1",
>> "linear", "premapped" ?
>
> "identity"?

I think that would be wrong, but thanks for trying to help :)

The address on the device side is sometimes (often?) offset from the CPU
address. So eg. the device can DMA to RAM address 0x0 using address
0x800000000000000.

Identity would imply 0 == 0 etc.

I think "bijective" is the correct term, but that's probably a bit
esoteric.

cheers
