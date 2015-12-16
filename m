From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 16 Dec 2015 16:15:15 +0100
Subject: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <5670098E.40601@arm.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
 <20151214141656.GG18805@8bytes.org>
 <1450150132.22854.57.camel@mhfsdcap03> <5670098E.40601@arm.com>
Message-ID: <20151216151514.GI18805@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 12:37:34PM +0000, Robin Murphy wrote:
> The potential issue I *do* see, looking more closely, is that
> iommu_group_get_for_dev() is setting group->domain but not calling
> the attach_dev callback, which looks wrong...

Attaching the device happens from iommu_group_add_device(), which is
called from iommu_group_get_for_dev() right after the domains are
allocated/initialized.


	Joerg
