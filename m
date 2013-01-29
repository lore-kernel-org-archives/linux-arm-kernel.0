From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 29 Jan 2013 12:54:46 +0200
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
 <CAKohpomO6tYNYLdMOaJYgqGecXj5KMQprdb=gExi+QuGrtLTzw@mail.gmail.com>
 <201301291035.30265.arnd@arndb.de>
 <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
Message-ID: <1359456886.31148.37.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 16:19 +0530, Viresh Kumar wrote: 
> On 29 January 2013 16:05, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 29 January 2013, Viresh Kumar wrote:

> >> > +       /* FIXME: This binding is rather clumsy. Can't we use the
> >> > +          request line numbers here instead? */
> >>
> >> yes.
> >
> > Ok, Very good. What is the encoding of the registers then?
> 
> You can still keep fargs as is and just fill them as:
> 
>        fargs.cfg_lo = 0;
> 
> if (DMA_TO_DEV)
>        // dest is periph
>        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 11;
> else if (DEV_TO_DMA)
>        // src is periph
>        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 7;

We have macros for such shifts.

drivers/dma/dw_dmac.c:187:   cfghi = DWC_CFGH_DST_PER(...
drivers/dma/dw_dmac.c:189:   cfghi = DWC_CFGH_SRC_PER(...

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
