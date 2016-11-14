From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 14 Nov 2016 14:44:29 -0800
Subject: [PATCH v2 0/6] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20161114144429.4386e89a2761504bde340032@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Nov 2016 15:07:33 +0800 Huang Shijie <shijie.huang@arm.com> wrote:

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

I'm not really seeing a description of the actual bug.  I don't know
what counter.sh is, there is no copy of counter.sh included in the
changelogs and there is no description of the kernel error which
counter.sh demonstrates.

So can you pleaser send to me a copy of counter.sh as well as a
suitable description of the kernel error which counter.sh triggers?
