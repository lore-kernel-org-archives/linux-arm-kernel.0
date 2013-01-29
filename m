From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Jan 2013 16:27:54 +0530
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <1359456886.31148.37.camel@smile>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
 <CAKohpomO6tYNYLdMOaJYgqGecXj5KMQprdb=gExi+QuGrtLTzw@mail.gmail.com>
 <201301291035.30265.arnd@arndb.de>
 <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
 <1359456886.31148.37.camel@smile>
Message-ID: <CAKohpokZfQZ17PmQjS2ntN9js7=SxNkiwWpX2aD8cZcM9L0ydw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2013 16:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2013-01-29 at 16:19 +0530, Viresh Kumar wrote:
>> if (DMA_TO_DEV)
>>        // dest is periph
>>        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 11;
>> else if (DEV_TO_DMA)
>>        // src is periph
>>        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 7;
>
> We have macros for such shifts.
>
> drivers/dma/dw_dmac.c:187:   cfghi = DWC_CFGH_DST_PER(...
> drivers/dma/dw_dmac.c:189:   cfghi = DWC_CFGH_SRC_PER(...

I am getting older now, bad memory :)
I grepped into drivers/dma/dw_dmac_regs.h and left include/linux/dw_dmac.h :(
