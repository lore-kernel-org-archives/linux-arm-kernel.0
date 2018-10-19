From: n-horiguchi@ah.jp.nec.com (Naoya Horiguchi)
Date: Fri, 19 Oct 2018 02:01:01 +0000
Subject: [PATCH V2 0/5] arm64/mm: Enable HugeTLB migration
In-Reply-To: <e1703454-e500-3a1b-35cb-6368dff91f10@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <e1703454-e500-3a1b-35cb-6368dff91f10@arm.com>
Message-ID: <20181019020101.GB18973@hori1.linux.bs1.fc.nec.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 01:49:17PM +0530, Anshuman Khandual wrote:
> 
> 
> On 10/12/2018 09:29 AM, Anshuman Khandual wrote:
> > This patch series enables HugeTLB migration support for all supported
> > huge page sizes at all levels including contiguous bit implementation.
> > Following HugeTLB migration support matrix has been enabled with this
> > patch series. All permutations have been tested except for the 16GB.
> > 
> >          CONT PTE    PMD    CONT PMD    PUD
> >          --------    ---    --------    ---
> > 4K:         64K     2M         32M     1G
> > 16K:         2M    32M          1G
> > 64K:         2M   512M         16G
> > 
> > First the series adds migration support for PUD based huge pages. It
> > then adds a platform specific hook to query an architecture if a
> > given huge page size is supported for migration while also providing
> > a default fallback option preserving the existing semantics which just
> > checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
> > HugeTLB migration on arm64 and subscribe to this new platform specific
> > hook by defining an override.
> > 
> > The second patch differentiates between movability and migratability
> > aspects of huge pages and implements hugepage_movable_supported() which
> > can then be used during allocation to decide whether to place the huge
> > page in movable zone or not.
> > 
> > Changes in V2:
> > 
> > - Added a new patch which differentiates migratability and movability
> >   of huge pages and implements hugepage_movable_supported() function
> >   as suggested by Michal Hocko.
> 
> Hello Andrew/Michal/Mike/Naoya/Catalin,
> 
> Just checking for an update. Does this series looks okay ?

Looks good to me. So for the series

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
