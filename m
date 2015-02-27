From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 26 Feb 2015 16:12:32 -0800
Subject: tlbi  va, vaa vs. val, vaal
Message-ID: <54EFB670.2070501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I noticed kernel tlbflush.h use tlbi va*, vaa* variants instead of
val, vaal ones. Reading the manual D.5.7.2 it appears that
va*, vaa* versions invalidate intermediate caching of
translation structures.

With stage2 enabled that may result in 20+ memory lookups
for a 4 level page table walk. That's assuming that intermediate
caching structures cache mappings from stage1 table entry to
host page.

- Mario
