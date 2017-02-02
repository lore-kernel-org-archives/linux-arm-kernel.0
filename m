From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Feb 2017 12:08:50 +0000
Subject: [PATCH v31 09/12] arm64: kdump: provide /proc/vmcore file
In-Reply-To: <20170202120320.GK31394@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-8-takahiro.akashi@linaro.org>
 <20170201192121.GB30584@leverpostej>
 <20170202062408.GC13549@linaro.org>
 <20170202120320.GK31394@leverpostej>
Message-ID: <20170202120850.GL31394@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 12:03:20PM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 03:24:09PM +0900, AKASHI Takahiro wrote:
> > On Wed, Feb 01, 2017 at 07:21:22PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 01, 2017 at 09:46:28PM +0900, AKASHI Takahiro wrote:

> > > > +/*
> > > > + * reserve_elfcorehdr() - reserves memory for elf core header
> > > > + *
> > > > + * This function reserves elf core header given in "elfcorehdr=" kernel
> > > > + * command line parameter. This region contains all the information about
> > > > + * primary kernel's core image and is used by a dump capture kernel to
> > > > + * access the system memory on primary kernel.
> > > > + */

> Can you also fix the comment above reserve_elfcorehdr()? It refers to a
> non-existent kernel command line option.

... or rather, one that's handled by core code, not
reserve_elfcorehdr().

So more specifically, it would be nicer to have something like:

	/*
	 * reserve_elfcorehdr() - reserves memory for elf core header
	 *
	 * This function reserves the memory occupied by an elf core header
	 * described in the device tree. This region contains all the
	 * information about primary kernel's core image and is used by a dump
	 * capture kernel to access the system memory on primary kernel.
	 */

Thanks,
Mark.
