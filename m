From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 Nov 2012 15:50:28 +0200
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
Message-ID: <50A0FEA4.20304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-12 15:39, Grazvydas Ignotas wrote:
> Hi,
> 
> On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> This series changes omapfb to use standard dma_alloc funcs instead of omap
>> specific vram allocator. This let's us remove the omap vram allocator, making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downsides:
>>
>> ...
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the
>> applications will interpret as "there's enough vram".
> 
> Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?

Yes.

>> 4) "vram" kernel parameter to define how much ram to reserve for video use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
> 
> That's a significant change, you should update Documentation/ .

Ah right. The documentation. I never remember =).

> What about omapfb.vram, is it still there?

Yes.

> Perhaps we also need to select/depend on CMA?

dma_alloc_* funcs work fine without CMA. CMA only makes them work
better. Thus I don't think OMAPFB should depend on CMA, but perhaps CMA
should be enabled by default in omap2plus_defconfig?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121112/e79a30b7/attachment.sig>
