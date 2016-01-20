From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 20 Jan 2016 14:46:34 +0000
Subject: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
In-Reply-To: <20160120133401.GA3487@localhost.localdomain>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
 <20160120120225.GD18805@8bytes.org>
 <20160120133401.GA3487@localhost.localdomain>
Message-ID: <569F9DCA.3030808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/16 13:34, Huang Shijie wrote:
> On Wed, Jan 20, 2016 at 01:02:25PM +0100, Joerg Roedel wrote:
>> On Tue, Jan 12, 2016 at 10:15:05AM +0800, Huang Shijie wrote:
>>> This patch adds a shortcut for the code when the @device_node is NULL.
>>> In my juno-r1 board, the boot time can be faster by 0.004014s.
>>
>> How have you made sure this number is reliable and not just noise in the
>> boot process?
> In the boot process, there are 5 or more modules whose @dev_node are
> NULL. Without the patch, the kernel will waste some cycles to do the
> meaningless calculations for all these modules.

With a quick counting hack, booting 4.4 on my r1 indeed shows 5 calls 
where dev_node is null. Plus 68 calls in which we waste cycles doing 
meaningless calculations when dev_node is non-null. The fundamental 
issue at hand is that the "platform bus" is a rubbish abstraction.

> In theory, it is not noise.
> If you have interest, I can send you the kernel boot logs. :)
>
> Of course, the 0.004014s maybe not accurate enough, it is just an
> approximate number.

A mean and standard deviation of at least, say, 5 runs each with and 
without the patch would be considerably more meaningful (even if still 
far from statistically significant).

Robin.

>
> Thanks
> Huang Shijie
>
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
