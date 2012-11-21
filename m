From: ruifeihuang@gmail.com (Jello huang)
Date: Wed, 21 Nov 2012 22:22:16 +0800
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <20121120221456.GO18567@atomide.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com> <50A5E801.3000100@ti.com>
 <20121120221456.GO18567@atomide.com>
Message-ID: <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Tomi,
we need  one rank of cma to allocate the memory for driver in kernel
space .And the default CMA is for allocating memory frome usespace.So
if we allocate the memory from the
default CMA zone ,there maybe introduce fragmention to the default CMA
zone.The kernel space memory donot touch the memory from userspace



Jello Huang

On 21/11/2012, Tony Lindgren <tony@atomide.com> wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121115 23:17]:
>>
>> I added your acks, and pushed:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git 3.8/vram-conversion
>>
>> It's based on -rc4 as my other branches are based on that.
>
> OK thanks!
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Thanks
Jello Huang
