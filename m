From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 20 Apr 2017 16:43:44 +0200
Subject: [PATCH] iommu: make iommu_bus_notifier return NOTIFY_DONE rather
 than  error code
In-Reply-To: <1492519908-65994-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1492519908-65994-1-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <20170420144343.GB21305@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:51:48PM +0800, zhichang.yuan wrote:
> In iommu_bus_notifier(), when action is BUS_NOTIFY_ADD_DEVICE, it will return
> 'ops->add_device(dev)' directly. But ops->add_device will return ERR_VAL, such
> as -ENODEV. These value will make notifier_call_chain() not to traverse the
> remain nodes in struct notifier_block list.
> 
> This patch revises iommu_bus_notifier() to return NOTIFY_DONE when some errors
> heppened in ops->add_device().
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>

Applied, thanks.
