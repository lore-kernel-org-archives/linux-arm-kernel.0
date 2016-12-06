From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 6 Dec 2016 18:03:59 +0800
Subject: [PATCH v3 0/4] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <20161205093100.GF30758@dhcp22.suse.cz>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
 <20161205093100.GF30758@dhcp22.suse.cz>
Message-ID: <20161206100358.GA4619@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 05:31:01PM +0800, Michal Hocko wrote:
> On Mon 05-12-16 17:17:07, Huang Shijie wrote:
> [...]
> >    The failure is caused by:
> >     1) kernel fails to allocate a gigantic page for the surplus case.
> >        And the gather_surplus_pages() will return NULL in the end.
> > 
> >     2) The condition checks for some functions are wrong:
> >         return_unused_surplus_pages()
> >         nr_overcommit_hugepages_store()
> >         hugetlb_overcommit_handler()
> 
> OK, so how is this any different from gigantic (1G) hugetlb pages on
I think there is no different from gigantic (1G) hugetlb pages on
x86_64. Do anyone ever tested the 1G hugetlb pages in x86_64 with the "counter.sh"
before? 

> x86_64? Do we need the same functionality or is it just 32MB not being
> handled in the same way as 1G?
Yes, we need this functionality for gigantic pages, no matter it is
X86_64 or S390 or arm64, no matter it is 32MB or 1G. :)

But anyway, I will try to find some machine and try the 1G gigantic page
on ARM64.

Thanks
Huang Shijie
