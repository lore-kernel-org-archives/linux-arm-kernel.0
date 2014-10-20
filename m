From: yifan.zhangm@gmail.com (Yifan Zhang)
Date: Mon, 20 Oct 2014 09:58:10 +0800
Subject: [PATCH v2] arm64: mm: use macro instead of if judgement of
 ZONE_DMA
In-Reply-To: <20141017132801.GH10873@e104818-lin.cambridge.arm.com>
References: <CAGZxSSSBpCvJt=PFbihTmPneJqiocU8VZSDHpXgkf5dhWZ850Q@mail.gmail.com>
 <20141016171012.GE5252@e104818-lin.cambridge.arm.com>
 <CAGZxSSSZ+b28rcHYRi5EWV9K4izHZBkO3fJTdang5XTaNMRTrw@mail.gmail.com>
 <20141017132801.GH10873@e104818-lin.cambridge.arm.com>
Message-ID: <CAGZxSSSPcfEWVhwisPder1j55uibJneJAZYyMR7=2OLgpGYM6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

No, we don't have any issues w/ current configuration. I'm just
confused why normal zone is empty in arm64 when I dumped zone info. If
it is on purpose, then I'm fine.

THX all for feedback!

BR,
Yifan

On Fri, Oct 17, 2014 at 9:28 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Oct 17, 2014 at 04:08:43AM +0100, Yifan Zhang wrote:
>> I found In current arm64 code, there is no normal zone, only DMA zone.
>>
>> Number of blocks type     Unmovable  Reclaimable      Movable
>> Reserve          CMA      Isolate
>>
>> Node 0, zone    DMA          142           12           69
>> 1           28            0
>>
>> When zone_sizes_init, zone_size[ZONE_NORMAL] is initialized to 0. (it
>> is 3.10, I didn't try the latest code base)
> [...]
>> Is this ZONE_DMA cover full memory and ZONE_NORMAL = 0 strategy on
>> purpose ? We will not use ZONE_NORMAL on arm64 ?
>
> The normal zone is still there, only that it doesn't have any pages. The
> page allocator falls back to the DMA zone, so you would not see any
> problems with normal page allocation.
>
> Are you trying to solve anything (performance?) or just what the kernel
> shows as part of the normal zone?
>
> --
> Catalin
