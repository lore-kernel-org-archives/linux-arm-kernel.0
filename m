From: mhocko@suse.com (Michal Hocko)
Date: Fri, 2 Dec 2016 15:05:57 +0100
Subject: [PATCH v2 0/6] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20161202140556.GN6830@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 14-11-16 15:07:33, Huang Shijie wrote:
> (1) Background
>    For the arm64, the hugetlb page size can be 32M (PMD + Contiguous bit).
>    In the 4K page environment, the max page order is 10 (max_order - 1),
>    so 32M page is the gigantic page.    
> 
>    The arm64 MMU supports a Contiguous bit which is a hint that the TTE
>    is one of a set of contiguous entries which can be cached in a single
>    TLB entry.  Please refer to the arm64v8 mannul :
>        DDI0487A_f_armv8_arm.pdf (in page D4-1811)
> 
> (2) The bug   
>    After I tested the libhugetlbfs, I found the test case "counter.sh"
>    will fail with the gigantic page (32M page in arm64 board).
> 
>    This patch set adds support for gigantic surplus hugetlb pages,
>    allowing the counter.sh unit test to pass.   

Andrew, I have noticed that this patchset is sitting in the mmotm tree
already. I have to say I am not really happy about the changes it is
introducing. It is making a confused code base even more so. I have
already commented on respective patches but in general I think it needs
a deeper thought before it can be merged.

-- 
Michal Hocko
SUSE Labs
