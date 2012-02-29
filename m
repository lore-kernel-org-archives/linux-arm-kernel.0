From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 12:31:51 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
Message-ID: <201202291231.52151.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 February 2012, Bill Carson wrote:
> +
> +/* 2M and 16M hugepage linux ptes are stored in mmu_context_t->huge_linux_pte
> + *
> + * 2M hugepage
> + * ===========
> + * one huge linux pte caters to two HW ptes,
> + *

I think this needs more explanation. Why do you use a 2MB hugepage with two ptes here?
Wouldn't it be more logical to use 1MB hugepages?

	Arnd
