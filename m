From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 20 Jan 2016 16:00:01 +0000
Subject: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
In-Reply-To: <569F9DCA.3030808@arm.com>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
 <20160120120225.GD18805@8bytes.org>
 <20160120133401.GA3487@localhost.localdomain> <569F9DCA.3030808@arm.com>
Message-ID: <1453305601.3417.12.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 14:46 +0000, Robin Murphy wrote:
> > Of course, the 0.004014s maybe not accurate enough, it is just an
> > approximate number.
> 
> A mean and standard deviation of at least, say, 5 runs each with and 
> without the patch would be considerably more meaningful (even if
> still 
> far from statistically significant).

It wouldn't surprise me if replacing the proposed change with an 'asm
volatile("nop")' or two also give a boot time delta of several
milliseconds (due to change in cache line alignment of functions). I
don't believe you can reliably measure such minor changes.

It doesn't mean that the proposed change isn't a good addition though,
it obviously results in less code getting executed for the cost of one
or two instructions for a compare and branch. 

-- 
Tixy
