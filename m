From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 8 May 2013 13:03:08 +0100
Subject: [RFC PATCH v2 05/11] mm: thp: Correct the HPAGE_PMD_ORDER check.
In-Reply-To: <20130508124417.GA29631@shutemov.name>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-6-git-send-email-steve.capper@linaro.org>
 <20130508124417.GA29631@shutemov.name>
Message-ID: <20130508120307.GA1407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 03:44:17PM +0300, Kirill A. Shutemov wrote:
> On Wed, May 08, 2013 at 10:52:37AM +0100, Steve Capper wrote:
> > All Transparent Huge Pages are allocated by the buddy allocator.
> > 
> > A compile time check is in place that fails when the order of a
> > transparent huge page is too large to be allocated by the buddy
> > allocator. Unfortunately that compile time check passes when:
> > HPAGE_PMD_ORDER == MAX_ORDER
> > ( which is incorrect as the buddy allocator can only allocate
> > memory of order strictly less than MAX_ORDER. )
> 
> It looks confusing to me. Shouldn't we fix what MAX_ORDER means instead?
> 

It confused me as I originally had 13 as the order and couldn't
allocate any 512MB THPs :-).

MAX_ORDER appears to be used quite a lot so I think it would be
safer to change the use case here rather than its meaning.

Cheers,
-- 
Steve
