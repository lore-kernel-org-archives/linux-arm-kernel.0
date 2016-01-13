From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Jan 2016 11:18:07 +0000
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <5696272E.8090408@huawei.com>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
 <569454F6.1060207@huawei.com> <20160112111531.GA4858@leverpostej>
 <5696272E.8090408@huawei.com>
Message-ID: <20160113111806.GC23370@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 06:30:06PM +0800, Xishi Qiu wrote:
> Hi Mark,
> 
> If I create swapper page tables by 4kb, not large page, then I use
> set_memory_ro() to change the pate table flag, does it have the problem
> too?

The splitting/merging problem would not apply.

However, you're going to waste a reasonable amount of memory by not
using section mappings in the swapper, and we gain additional complexity
in the page table setup code (which is shared with others things that
want section mappings).

What are you exactly actually trying to achieve?

What memory do you want to mark RO, and why?

>From a previous discussion [1], we figured out alternative approaches
for common cases. Do none of those work for your case?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397320.html
