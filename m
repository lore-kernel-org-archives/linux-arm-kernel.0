From: robherring2@gmail.com (Rob Herring)
Date: Wed, 7 Aug 2013 08:08:13 -0500
Subject: [PATCH v4 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <xa1ttxj2luxi.fsf@mina86.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-4-git-send-email-m.szyprowski@samsung.com>
 <CAL_JsqK7FNeqbx2DFHou5xeU08L4Stn+NrHUmFjap_A1pEq9JQ@mail.gmail.com>
 <xa1ttxj2luxi.fsf@mina86.com>
Message-ID: <CAL_JsqLKYn3pnRPVdDYnpHfFudJBo_bHLD10c-QF8yUJkLMNcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 6, 2013 at 10:07 AM, Michal Nazarewicz <mina86@mina86.com> wrote:
> On Tue, Aug 06 2013, Rob Herring wrote:
>>> +static void reserved_mem_release_device_from_dt(struct device *dev)
>>> +{
>>> +       struct reserved_mem *region = get_dma_memory_region(dev);
>>> +       if (!region)
>>> +               return;
>>> +       if (!region->cma)
>>
>> if (region && !region->cma)
>
> !region case is handled two lines above, so no need to check if region
> is not null.

Right. Sorry if I was not clear. Combine the 3 lines into 1 line.

Rob
