From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Feb 2012 11:36:59 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <4F4E0BDE.6040708@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
 <20120229103207.GB17745@arm.com> <4F4E0BDE.6040708@gmail.com>
Message-ID: <20120229113658.GC17745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 11:28:30AM +0000, bill4carson wrote:
> On 2012?02?29? 18:32, Catalin Marinas wrote:
> > On Mon, Feb 13, 2012 at 09:44:22AM +0000, Bill Carson wrote:
> >> +static int __init add_huge_page_size(unsigned long long size)
> >> +{
> >> +	int shift = __ffs(size);
> >> +	u32 mmfr3 = 0;
> >> +
> >> +	/* Check that it is a page size supported by the hardware and
> >> +	 * that it fits within pagetable and slice limits. */
> >> +	if (!is_power_of_2(size) || (shift != HPAGE_SHIFT))
> >> +		return -EINVAL;
> >
> > You could use get_order() instead of __ffs(), the latter just finds the
> > first bit set.
> 
> With all due respect, I'm afraid I can't agree with you on this.
> here, we should use __ffs to return this "shift" not the order.
> 
> For "hugepagesz=2M", hpage_shift/HPAGE_SHIFT should be set to 21,
> *not* the order 9(21-12), that's what HUGETLB_PAGE_ORDER for.

I agree (I got confused by get_order() and log2()).

-- 
Catalin
