From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 16:38:37 +0000
Subject: [PATCH 1/2] iommu/arm-smmu: Replace list walk with platform
 driver data
In-Reply-To: <1393601830-4677-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1393601830-4677-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140228163837.GC30996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Feb 28, 2014 at 03:37:09PM +0000, Laurent Pinchart wrote:
> Instead of walking the list of registered SMMU devices at remove time to
> locate the device being removed, set platform driver data at probe time
> to point to the SMMU and retrieve the pointer at remove time.

What does this gain us other than a slight code shrinkage? If we could get
rid of the arm_smmu_devices list, then I'd be more excited by this change!

Will
