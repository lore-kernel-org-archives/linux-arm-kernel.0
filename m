From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 11 Nov 2016 17:27:36 +0100
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
In-Reply-To: <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
Message-ID: <20161111162736.GV2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 04:17:37PM +0000, Robin Murphy wrote:
> In the original of_iommu_configure design, the thought was that an ops
> structure could be IOMMU-instance-specific (hence the later-removed
> "priv" member), so I suppose right now it is mostly a hangover from
> that. However, it's also what we initialise a device's fwspec with, so
> becomes important again if we're ever going to get past the limitations
> of buses-which-are-not-actually-buses[1].

Yeah, I discussed this with a few others at LPC. My current idea is to
tell the iommu-core which hardware-iommus exist in the system and a
seperate iommu_ops ptr for each of them. Then every struct device can
link to the iommu-instance it is translated by.

We are not there yet, but this will give you the same per-device
iommu-ops as implemented here.



	Joerg
