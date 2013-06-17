From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 17 Jun 2013 21:27:21 +0530
Subject: MUSB multiplatform work?
In-Reply-To: <20130617134304.GD10671@intel.com>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
 <CACRpkdZHupVFS+pNADpaJjunPa3fEtyCqLwbL-etHs3gt8EW0Q@mail.gmail.com>
 <20130530203132.GC6467@atomide.com>
 <CACRpkdaUegc7B8awUiQTvFRJHPMWv6hEEsE-2AHtZCDXVEMN9g@mail.gmail.com>
 <20130612100542.GV4107@intel.com>
 <CAJe_ZheT6q6YnWU=1_bdwGE4-n9WNJyADFQ_TpQckuVfYai7zw@mail.gmail.com>
 <20130617134304.GD10671@intel.com>
Message-ID: <CABb+yY0gVbDx9qqJyj1LYhg9bKxU3t4X9a+EuVG+kXDazophKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 7:13 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Jun 12, 2013 at 05:27:53PM +0530, Jassi Brar wrote:
>> IIRC,  TI's Sundaram Raju proposed a TI specific api to DMAEngine for
>> this very purpose, which was generalized into
>> device_prep_interleaved_dma().  Which I think should already be enough
>> to serve the purpose. Is it not?
> The interleaved for having to get/set data from interleaved or an 2d array.
> Think of a raw image from camera where you need to get some region only and skip
> rest. In those case interleaved API helps
>
IIRC I designed the interleaved api ;)  and I am sure it was not
designed solely for async, rather the first users of the api are
slave.

> Here this is just normal slave DMA with changing FIFO address and which just
> loops over the FIFO value
>
It is possible that I didn't understand the OMAP usecase and the
interleave api won't work, but if it does work please let us not
introduce yet another api for a 'normal' usecase.

In fact my bigger plan was to call the api 'generic' and have it
eventually consume most, if not all, dma_transaction_type's but then
we couldn't see the same and I got busy with non-dma stuff ...
anyways.

cheers.
