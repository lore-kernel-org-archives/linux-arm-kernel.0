From: lorenx4@gmail.com (Lorenzo Nava)
Date: Wed, 20 May 2015 14:57:36 +0200
Subject: [RFC] arm: DMA-API contiguous cacheable memory
In-Reply-To: <20150519223444.GO2067@n2100.arm.linux.org.uk>
References: <CAE=W-e24oDH5RZfPftRg_xYBiG+b9Sj09vpyay9EwqOo9cVX1w@mail.gmail.com>
 <20150519163436.GZ21251@e104818-lin.cambridge.arm.com>
 <CAE=W-e1qynowbccHpYntWwwZPZOMHAVXH=Yj3ukyr_X8WKwQJQ@mail.gmail.com>
 <2882347.Nj1Dq9Wlqh@wuerfel>
 <20150519223444.GO2067@n2100.arm.linux.org.uk>
Message-ID: <CAE=W-e2LZN9cEvTQNm0z1_ZMg1mKs=o2TcEy5QRkiEPMMFWuPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:34 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, May 20, 2015 at 12:14:48AM +0200, Arnd Bergmann wrote:
>> With that memory, you should be able to use the normal streaming
>> API (dma_sync_single_for_*).
>
> Wrong, as I've pointed out previously.  The only memory which you're
> allowed to sync is with memory which has been mapped with a dma_map_*()
> function.
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.

Russell,

so probably currently is impossible to allocate a contiguous cachable
DMA memory. You can't use CMA, and the only functions which allow you
to use it are not compatible with sync functions.
Do you think the problem is the CMA design, the DMA API design, or
there is no problem at all and this is not something useful?
Anyway it's not completely clear to me which is the difference between:
  - allocating memory and use sync function on memory mapped with dma_map_*()
  - allocating memory with dma_alloc_*() (with cacheable attributes)
and use the sync functions on it
It looks that the second just make alloc + map in a single step
instead of splitting the operation in two steps.
I'm sure I'm losing something, can you please help me understand that?

Thanks.
Lorenzo
