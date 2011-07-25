From: pj0585@gmail.com (P J)
Date: Mon, 25 Jul 2011 19:36:55 +0530
Subject: at91sam9g45: Issues while working with RAM that is separated on
	physical address space
In-Reply-To: <20110722135505.GB25947@n2100.arm.linux.org.uk>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
	<20110722135505.GB25947@n2100.arm.linux.org.uk>
Message-ID: <CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jul 22, 2011 at 7:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 22, 2011 at 07:06:40PM +0530, P J wrote:
>> The memory map (required) is as follows:
>> ? ? phys ? ? ? ? ? => ? ? ? ? ?virt
>> 0x70000000 ? ?=> ? ?0xC0000000 ?(128 MB)
>> 0x20000000 ? ?=> ? ?0xC8000000 ?(128 MB)
>
> There is no way that the kernel will support this kind of hair-brained
> memory layout. ?This is even more true than it once was since we've moved
> to using memblock to manage the physical memory layout in later kernels.
>
> What the kernel will support is using 0x20000000 as the first bank and
> 0x70000000 as the second bank of memory. ?I suggest trying with it mapped
> that way around, and failing that then using highmem support without
> sparse.
>

I do not completely understand why this layout is not possible.

Anyways, my one memory bank (128 MB DDR2) is located at physical
address 0x70000000 to 0x77FFFFFF and is virtually mapped to 0xC0000000
to 0xC7FFFFFF.

If I have to continue to use this bank as per the above mapping then
how can I use the other memory bank (128MB DDR2) which is located at
physical address 0x20000000 to 0x27FFFFFF ?


-Prasant J
