From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 02 Mar 2014 18:59:27 +0100
Subject: [PATCH 1/2] iommu/arm-smmu: Replace list walk with platform
 driver data
In-Reply-To: <20140228163837.GC30996@mudshark.cambridge.arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1393601830-4677-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140228163837.GC30996@mudshark.cambridge.arm.com>
Message-ID: <4440723.cnxQ5HD11R@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Friday 28 February 2014 16:38:37 Will Deacon wrote:
> Hi Laurent,
> 
> On Fri, Feb 28, 2014 at 03:37:09PM +0000, Laurent Pinchart wrote:
> > Instead of walking the list of registered SMMU devices at remove time to
> > locate the device being removed, set platform driver data at probe time
> > to point to the SMMU and retrieve the pointer at remove time.
> 
> What does this gain us other than a slight code shrinkage?

Just a slight code shrinkage. That's better than nothing, isn't it ? :-)

> If we could get rid of the arm_smmu_devices list, then I'd be more excited
> by this change!

Associating devices with IOMMUs is something that should be performed by the 
IOMMU core. I might give this a try, but I'll be busy with other tasks for the 
next couple of weeks.

-- 
Regards,

Laurent Pinchart
