From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 24 Oct 2018 15:58:59 +0200
Subject: [PATCH V3 3/5] mm/hugetlb: Enable arch specific huge page size
 support for migration
In-Reply-To: <20181024135639.GH18839@dhcp22.suse.cz>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-4-git-send-email-anshuman.khandual@arm.com>
 <20181024135639.GH18839@dhcp22.suse.cz>
Message-ID: <20181024135859.GI18839@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 24-10-18 15:56:39, Michal Hocko wrote:
> On Tue 23-10-18 18:31:59, Anshuman Khandual wrote:
> > Architectures like arm64 have HugeTLB page sizes which are different than
> > generic sizes at PMD, PUD, PGD level and implemented via contiguous bits.
> > At present these special size HugeTLB pages cannot be identified through
> > macros like (PMD|PUD|PGDIR)_SHIFT and hence chosen not be migrated.
> > 
> > Enabling migration support for these special HugeTLB page sizes along with
> > the generic ones (PMD|PUD|PGD) would require identifying all of them on a
> > given platform. A platform specific hook can precisely enumerate all huge
> > page sizes supported for migration. Instead of comparing against standard
> > huge page orders let hugetlb_migration_support() function call a platform
> > hook arch_hugetlb_migration_support(). Default definition for the platform
> > hook maintains existing semantics which checks standard huge page order.
> > But an architecture can choose to override the default and provide support
> > for a comprehensive set of huge page sizes.
> > 
> > Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Acked-by: Michal Hocko <mhocko@use.com>

fat fingers here, should be mhocko at suse.com of course.
-- 
Michal Hocko
SUSE Labs
