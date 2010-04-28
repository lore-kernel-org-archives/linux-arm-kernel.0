From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Apr 2010 16:53:40 +0900
Subject: CONSISTENT_DMA_SIZE limitations
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5172F4B@dbde02.ent.ti.com>
References: <v2taec7e5c31004272325x9e5958ddp34d7db1ff3477f4d@mail.gmail.com>
	<n2rf17812d71004272347m63c1f3f3k71005f720110822e@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5172F4B@dbde02.ent.ti.com>
Message-ID: <m2gaec7e5c31004280053kbc268921g75f7d447ea966576@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Wed, Apr 28, 2010 at 4:07 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> On Wed, Apr 28, 2010 at 2:25 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > Extending CONSISTENT_DMA_SIZE seems like a good idea to me, but I'm
>> > not sure if doing so will break something else. Perhaps I need to
>> > rework some code in arch/arm/mm/dma-mapping.c?

> Not the best way but works is :
> You can override the default setting of 2MB to whatever memory you need and
> then use the dma_alloc_coherent(), to allocate from this space.
>
> Just ensure that you don't ioremap this memory with different cache-attribute
> otherwise you will end up in the alias mapping of same memory which is not
> allowed on newer ARMv7.

Good idea. =) Thanks for your suggestions.

/ magnus
