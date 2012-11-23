From: ruifeihuang@gmail.com (Jello huang)
Date: Fri, 23 Nov 2012 18:07:13 +0800
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <50AE2E15.2070501@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com> <50A5E801.3000100@ti.com>
 <20121120221456.GO18567@atomide.com>
 <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
 <50AE2E15.2070501@ti.com>
Message-ID: <CAPFyZi4HPRg==bbyW93wtKmR5qG3fOqK_VNGuVGz0tpQ8QrxfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi
Sorry donot describe clearly.
>>How do you allocate CMA memory from userspace
 memory is allocated by userland then  pass the size to kernel space

I mean that we can split two parts of memory heap .one for the kernel space
and other for userland app. we can use dma_declare_contiguous to declare
one dma device A and B .Then the all kernel driver allocate from A .The
other B allocate for userland


On 22 November 2012 21:52, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Hi,
>
> On 2012-11-21 16:22, Jello huang wrote:
> > HI Tomi,
> > we need  one rank of cma to allocate the memory for driver in kernel
> > space .And the default CMA is for allocating memory frome usespace.So
> > if we allocate the memory from the
> > default CMA zone ,there maybe introduce fragmention to the default CMA
> > zone.The kernel space memory donot touch the memory from userspace
>
> Can you elaborate a bit? I didn't understand your point. Are you saying
> each kernel driver that uses dma_alloc should have their own CMA zone?
> That doesn't make sense...
>
> How do you allocate CMA memory from userspace?
>
>  Tomi
>
>
>


-- 
Thanks
Jello Huang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/0c141965/attachment.html>
