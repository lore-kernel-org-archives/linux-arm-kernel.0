From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 06 Aug 2013 17:33:03 +0200
Subject: [PATCH v4 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <xa1ttxj2luxi.fsf@mina86.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-4-git-send-email-m.szyprowski@samsung.com>
 <CAL_JsqK7FNeqbx2DFHou5xeU08L4Stn+NrHUmFjap_A1pEq9JQ@mail.gmail.com>
 <xa1ttxj2luxi.fsf@mina86.com>
Message-ID: <5201172F.5050803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2013 05:07 PM, Michal Nazarewicz wrote:
> On Tue, Aug 06 2013, Rob Herring wrote:
>>> >> +static void reserved_mem_release_device_from_dt(struct device *dev)
>>> >> +{
>>> >> +       struct reserved_mem *region = get_dma_memory_region(dev);
>>> >> +       if (!region)
>>> >> +               return;
>>> >> +       if (!region->cma)
>> >
>> > if (region && !region->cma)
>
> !region case is handled two lines above, so no need to check if region
> is not null.

I think Rob's suggestion was to replace two 'if' statements with a single
one, which makes sense.


Thanks,
Sylwester
