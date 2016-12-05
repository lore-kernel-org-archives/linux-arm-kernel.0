From: mhocko@suse.com (Michal Hocko)
Date: Mon, 5 Dec 2016 10:31:01 +0100
Subject: [PATCH v3 0/4] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20161205093100.GF30758@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 05-12-16 17:17:07, Huang Shijie wrote:
[...]
>    The failure is caused by:
>     1) kernel fails to allocate a gigantic page for the surplus case.
>        And the gather_surplus_pages() will return NULL in the end.
> 
>     2) The condition checks for some functions are wrong:
>         return_unused_surplus_pages()
>         nr_overcommit_hugepages_store()
>         hugetlb_overcommit_handler()

OK, so how is this any different from gigantic (1G) hugetlb pages on
x86_64? Do we need the same functionality or is it just 32MB not being
handled in the same way as 1G?

Thanks!
-- 
Michal Hocko
SUSE Labs
