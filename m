From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 5 Dec 2016 11:15:43 +0800
Subject: [PATCH V2 fix 5/6] mm: hugetlb: add a new function to allocate a
 new gigantic page
In-Reply-To: <20161202140325.GM6830@dhcp22.suse.cz>
References: <1479107259-2011-6-git-send-email-shijie.huang@arm.com>
 <1479279304-31379-1-git-send-email-shijie.huang@arm.com>
 <20161202140325.GM6830@dhcp22.suse.cz>
Message-ID: <20161205031542.GB13468@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 03:03:30PM +0100, Michal Hocko wrote:
> On Wed 16-11-16 14:55:04, Huang Shijie wrote:
> > There are three ways we can allocate a new gigantic page:
> > 
> > 1. When the NUMA is not enabled, use alloc_gigantic_page() to get
> >    the gigantic page.
> > 
> > 2. The NUMA is enabled, but the vma is NULL.
> >    There is no memory policy we can refer to.
> >    So create a @nodes_allowed, initialize it with init_nodemask_of_mempolicy()
> >    or init_nodemask_of_node(). Then use alloc_fresh_gigantic_page() to get
> >    the gigantic page.
> > 
> > 3. The NUMA is enabled, and the vma is valid.
> >    We can follow the memory policy of the @vma.
> > 
> >    Get @nodes_allowed by huge_nodemask(), and use alloc_fresh_gigantic_page()
> >    to get the gigantic page.
> 
> Again __hugetlb_alloc_gigantic_page is not used and it is hard to deduce
> its usage from this commit. The above shouldn't be really much different from

Okay, I will merge it into the later patch.

> what we do in alloc_pages_vma so please make sure to check it before
> coming up with something hugetlb specific.
No problem. Thanks for the hint.

Thanks
Huang Shijie
