From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 8 Jan 2014 16:13:39 +0200
Subject: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
In-Reply-To: <20140107235951.GH5074@atomide.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com>
Message-ID: <52CD5D13.9090806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-08 01:59, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131230 05:21]:
>> The omapfb driver uses dma_alloc to reserve memory for the framebuffers.
>> However, on some use cases, even when CMA is in use, it's quite probable
>> that omapfb fails to allocate the fb, either due to not enough free dma
>> memory, fragmented dma memory, or CMA failing to make enough contiguous
>> space.
>>
>> This patch adds a kernel cmdline parameter 'omapfb_vram' which can be
>> used to give the size of a memory area reserved exclusively for omapfb,
>> and optionally a physical address where the memory area is reserved.
>>
>> The memory area is reserved with memblock, and assigned to omapfb with
>> dma_declare_coherent_memory. The dma_alloc function will first try to
>> allocate the fb from the coherent memory area, and if that fails, it'll
>> use the normal method of allocation.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Ivaylo Dimitrov <freemangordon@abv.bg>
> 
> Feel free to queue this along with the DSS patches:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

This introduces new kernel boot parameter, and I haven't really had time
to test and think about this. If Ivaylo doesn't insist on this to be
merged for 3.14, I'd rather leave this for 3.15 as adding new parameter
that we need to support "forever" should be thought a bit more.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/5a22d129/attachment.sig>
