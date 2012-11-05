From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 5 Nov 2012 10:04:41 +0200
Subject: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
In-Reply-To: <20121102185453.GY15766@atomide.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224828.2103.82950.stgit@muffinssi.local> <50936A6E.3020202@ti.com>
 <5093891D.6070302@ti.com> <50938A69.9040908@ti.com>
 <20121102154901.GU15766@atomide.com> <20121102185453.GY15766@atomide.com>
Message-ID: <50977319.9070902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-02 20:54, Tony Lindgren wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [121102 01:56]:
>>> On Friday 02 November 2012 02:19 PM, Tomi Valkeinen wrote:
>>>> On 2012-11-02 08:38, Santosh Shilimkar wrote:
>>>>>
>>>>> Lets not move this in DMA code since the above is really related
>>>>> to frame buffer. It reserves more DMA area for dma_alloc_coherent()
>>>>> etc than default 2 MB. Infact, we should no longer need this with
>>>>> CMA and memblock in place.
>>>>>
>>>>> Tomi,
>>>>> Can we not get rid of the above memory reservation ?
>>>>
>>>> Yes, I think so. This one is only used for the old omapfb, i.e. omap1,
>>>> and I have no means to test it out, though. But below is a patch to
>>>> remove it. I also attached the patch, as it looks like thunderbird wants
>>>> to reformat the pasted patch... I'll remove the
>>>> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE from the omapfb driver's Kconfig file
>>>> in my tree later.
> 
> Hmm actually, is it safe to remove for omap1, or should we
> still keep it around for omap1?

Why wouldn't it be safe? Do you mean that CMA doesn't work on omap1,
or...? I'm no expert on CMA, but as far as I can see with it's ARM
generic stuff.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/106f3a2e/attachment.sig>
