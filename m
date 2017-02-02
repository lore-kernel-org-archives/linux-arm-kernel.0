From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Feb 2017 11:26:20 +0000
Subject: [PATCH v31 03/12] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170202045235.GB13549@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-2-takahiro.akashi@linaro.org>
 <20170201152609.GE4756@leverpostej>
 <20170202045235.GB13549@linaro.org>
Message-ID: <20170202112619.GB31394@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 01:52:36PM +0900, AKASHI Takahiro wrote:
> On Wed, Feb 01, 2017 at 03:26:09PM +0000, Mark Rutland wrote:
> > On Wed, Feb 01, 2017 at 09:46:22PM +0900, AKASHI Takahiro wrote:
> > > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > > +		crash_size >> 20, crash_base >> 20);
> > 
> > We only page-align the size, so the MB will be a little off, but that's
> > probably OK. However, it would also be nicer to log the base as an
> > address.
> 
> You might notice that the exact same message is used by all the other
> architectures, but

Almost all; I see arch/sh prints the address with %08x. ;)

> > Could we dump this as we do for the kernel memory layout? e.g.
> > 
> > 	pr_info("crashkernel reserved: 0x%016lx - 0x%016lx (%lld MB)\n",
> > 		crash_base, crash_base + crash_size, crash_size >> 20);
> 
> We can go either way.

Even if it's different from other archtiectures, I'd prefer to log as
above, with the range in hex.

Thanks,
Mark.
