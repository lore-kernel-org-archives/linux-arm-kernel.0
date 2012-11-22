From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 22 Nov 2012 15:52:21 +0200
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com> <50A5E801.3000100@ti.com>
 <20121120221456.GO18567@atomide.com>
 <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
Message-ID: <50AE2E15.2070501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2012-11-21 16:22, Jello huang wrote:
> HI Tomi,
> we need  one rank of cma to allocate the memory for driver in kernel
> space .And the default CMA is for allocating memory frome usespace.So
> if we allocate the memory from the
> default CMA zone ,there maybe introduce fragmention to the default CMA
> zone.The kernel space memory donot touch the memory from userspace

Can you elaborate a bit? I didn't understand your point. Are you saying
each kernel driver that uses dma_alloc should have their own CMA zone?
That doesn't make sense...

How do you allocate CMA memory from userspace?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/69798536/attachment.sig>
