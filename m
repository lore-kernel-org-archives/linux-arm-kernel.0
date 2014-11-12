From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 12 Nov 2014 16:02:34 +0100
Subject: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <20141112144715.GD26488@ulmo>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
 <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
 <20141112142150.GV10744@8bytes.org> <20141112144715.GD26488@ulmo>
Message-ID: <20141112150233.GW10744@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 03:47:16PM +0100, Thierry Reding wrote:
> The SMMU is part of a larger IP block that's also a memory controller.
> Having it in drivers/iommu would mean that we need to provide a
> mechanism to synchronize between the two drivers. They also share a
> number of data tables, so that would need to be shared somehow as well.
> By keeping both in the same directory we don't have to expose any of
> this publicly.

Since these parts are in different files you export the interfaces
anyway through non-static symbols and those dependencys also exist for
other IOMMU drivers. So I prefer this file to live in drivers/iommu.


	Joerg
