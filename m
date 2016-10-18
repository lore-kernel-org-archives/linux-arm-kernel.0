From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 18 Oct 2016 19:21:49 +0800
Subject: [RFC] reduce latency in __purge_vmap_area_lazy
In-Reply-To: <1476773771-11470-1-git-send-email-hch@lst.de>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
Message-ID: <20161018192149.3de86109@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2016 08:56:05 +0200 Christoph Hellwig wrote:

> Hi all,
> 
> this is my spin at sorting out the long lock hold times in
> __purge_vmap_area_lazy.  It is based on the patch from Joel sent this
> week.  I don't have any good numbers for it, but it survived an
> xfstests run on XFS which is a significant vmalloc user.  The
> changelogs could still be improved as well, but I'd rather get it
> out quickly for feedback and testing.

I just tested this series, the preempt off ftrace log doesn't complain
__purge_vmap_area_lazy any more in my test case, this latency is removed!

So feel free to add

Tested-by: Jisheng Zhang <jszhang@marvell.com>
