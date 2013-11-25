From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 25 Nov 2013 11:46:53 +0100
Subject: [PATCH] CMA: Fix the phys_addr_t print types
In-Reply-To: <52918071.10408@ti.com>
References: <1385264221-29952-1-git-send-email-santosh.shilimkar@ti.com>
 <20131124034426.GB3873@kroah.com> <52917661.6050005@ti.com>
 <20131124041056.GA7415@kroah.com> <52918071.10408@ti.com>
Message-ID: <52932A9D.3050305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2013-11-24 05:28, Santosh Shilimkar wrote:
> On Saturday 23 November 2013 11:10 PM, Greg Kroah-Hartman wrote:
> > On Sat, Nov 23, 2013 at 10:45:37PM -0500, Santosh Shilimkar wrote:
> >> On Saturday 23 November 2013 10:44 PM, Greg Kroah-Hartman wrote:
> >>> On Sat, Nov 23, 2013 at 10:37:01PM -0500, Santosh Shilimkar wrote:
> >>>> @@ -250,8 +249,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
> >>>>  	*res_cma = cma;
> >>>>  	cma_area_count++;
> >>>>
> >>>> -	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
> >>>> -		(unsigned long)base);
> >>>> +	pr_info("CMA: reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
> >>>> +		&base);
> >>>
> >>> Why is this pr_info() at all?  That's just noise, please move it to
> >>> pr_debug().
> >>>
> >> Marek can comment better but I think its useful print to know CMA
> >> reserved memory size.
> >
> > Useful to who?
> >
> Useful to anyone wants to know the CMA usage on a platform.
> CMA size is configurable and platforms tend to use different sizes
> based on needs. The info don't appear in /proc/meminfo, so probably
> dmsg grep is easy enough to know how much CMA memory being used on
> a platform. That was my point.
>
> I don't have strong argument here against not making it pr_debug
> but was waiting for Marek's opinion on it.

If possible I would like to keep pr_info. It already helped me a lot
while analyzing someone's logs to find why memory allocation failed.
A simple search for "CMA" messages enabled me to quickly check if CMA
has been enabled and configured properly or not. It also gives a curious
user some information about the memory configuration (especially if he
don't need CMA, he will investigate why kernel has reserved so much
memory).

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
