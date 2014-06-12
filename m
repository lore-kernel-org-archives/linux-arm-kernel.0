From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 12 Jun 2014 16:56:38 +0900
Subject: [PATCH v2 10/10] mm, cma: use spinlock instead of mutex
In-Reply-To: <20140612074029.GB12663@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-11-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612074029.GB12663@bbox>
Message-ID: <20140612075638.GD20199@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 04:40:29PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:47PM +0900, Joonsoo Kim wrote:
> > Currently, we should take the mutex for manipulating bitmap.
> > This job may be really simple and short so we don't need to sleep
> > if contended. So I change it to spinlock.
> 
> I'm not sure it would be good always.
> Maybe you remember we discussed about similar stuff about bitmap
> searching in vmap friend internally, which was really painful
> when it was fragmented. So, at least we need number if you really want
> and I hope the number from ARM machine most popular platform for CMA
> at the moment.

Good Point!! Agreed. I will drop this one in next spin and re-submit
in separate patchset after some testing.

Thanks.
