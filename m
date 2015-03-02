From: thunder.leizhen@huawei.com (leizhen)
Date: Mon, 2 Mar 2015 16:02:12 +0800
Subject: [Question] How can we support outer shareable on ARM64?
Message-ID: <54F41904.90303@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Now, both cacheable memory shareability attribute and barrier are fixed to inner shareable. But
I afraid some hardware need outer shareable. If hardware support both inner and outer, do we need
to optimize?

for example(the code for now):
#define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
#define smp_mb()	dmb(ish)

How can we support both inner and outer shareable, or selectable?

Thanks
Zhen Lei
