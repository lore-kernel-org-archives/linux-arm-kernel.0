From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 4 Nov 2016 09:59:10 +0800
Subject: [PATCH 0/2] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <0a660010-5083-476a-b2c5-88d822089000@infradead.org>
References: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
 <0a660010-5083-476a-b2c5-88d822089000@infradead.org>
Message-ID: <20161104015909.GB19470@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 10:22:39AM -0700, Randy Dunlap wrote:
> On 11/02/16 19:51, Huang Shijie wrote:
> > 
> > (2) The bug   
> >    After I tested the libhugetlbfs, I found the test case "counter.sh"
> >    will fail with the gigantic page (32M page in arm64 board).
> > 
> >    This patch set adds support for gigantic surplus hugetlb pages,
> >    allowing the counter.sh unit test to pass.   
> 
> Hi,
> Where is the counter.sh test? Where can I find it?
You can get the libhugetlbfs from:
   https://github.com/libhugetlbfs/libhugetlbfs.git

Use the "make func" to test it, but the default libhugetlbfs can not run
for the 32M page hugetlbfs, there are several bugs in it. I have an
extra patch set to fix the libhugetlbfs bugs. Maybe I can send them out
later.

But for the 2M page size, you can test the "counter.sh" with "make
func".

thanks
Huang Shijie
