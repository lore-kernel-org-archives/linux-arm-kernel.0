From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Feb 2013 12:17:48 +0000
Subject: [PATCH] ARM: mm: use phys_addr_t for physical address when
 populating pud
In-Reply-To: <512C7586.1020206@ti.com>
References: <1361805410-8664-1-git-send-email-will.deacon@arm.com>
 <512C7586.1020206@ti.com>
Message-ID: <20130226121747.GA26418@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 08:42:46AM +0000, Santosh Shilimkar wrote:
> Will,

Hi Santosh,

> On Monday 25 February 2013 08:46 PM, Will Deacon wrote:
> > When creating our initial mappings, we call alloc_init_pud, which
> > simply defers to alloc_init_section for mappings at the pmd level.
> >
> > However, the physical address passed to alloc_init_pud is potentially
> > truncated to unsigned long, which could cause problems on systems making
> > use of LPAE.
> >
> > This patch fixes the function prototype to use phys_addr_t.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> There is already a similar patch [1] on list which was suppose
> to get merged in 3.9 from Cyril's series [2]

Nice, that series contains a number of similar fixes too. However, I can't
see anywhere destined for upstream.

Cyril -- what's the status on this branch?

Cheers,

Will
