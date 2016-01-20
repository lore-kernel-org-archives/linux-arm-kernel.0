From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 20 Jan 2016 21:34:03 +0800
Subject: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
In-Reply-To: <20160120120225.GD18805@8bytes.org>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
 <20160120120225.GD18805@8bytes.org>
Message-ID: <20160120133401.GA3487@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 01:02:25PM +0100, Joerg Roedel wrote:
> On Tue, Jan 12, 2016 at 10:15:05AM +0800, Huang Shijie wrote:
> > This patch adds a shortcut for the code when the @device_node is NULL.
> > In my juno-r1 board, the boot time can be faster by 0.004014s.
> 
> How have you made sure this number is reliable and not just noise in the
> boot process?
In the boot process, there are 5 or more modules whose @dev_node are
NULL. Without the patch, the kernel will waste some cycles to do the
meaningless calculations for all these modules. In theory, it is not noise.
If you have interest, I can send you the kernel boot logs. :)

Of course, the 0.004014s maybe not accurate enough, it is just an
approximate number.

Thanks
Huang Shijie
