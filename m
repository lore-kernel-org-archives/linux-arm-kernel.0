From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 3 Apr 2017 13:07:58 +0200
Subject: [PATCH] iommu/rockchip: Make use of 'struct iommu_device'
In-Reply-To: <1785458.LaVlbOJ67B@diego>
References: <1490970624-19981-1-git-send-email-joro@8bytes.org>
 <1785458.LaVlbOJ67B@diego>
Message-ID: <20170403110758.GB4683@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Heiko,

On Mon, Apr 03, 2017 at 11:56:59AM +0200, Heiko St?bner wrote:
> In general works, and I still keep a working iommu-based display :-)
> I can also see my two vop iommus under /sys/class/iommu now.

Great, thanks for testing that patch!

> Links in the devices subdirectory do not work though, see below:

Okay, thats bad, but I think its nothing we should work around right
now. My goal with this work is to have a per-iommu check-device
call-back to bind devices to iommus in the core code.

This will also solve the probe-ordering issue and we are fine again. We
just call check-device then for every device on the bus that has no
iommu already when the iommu is registered and create the links at that
time.



	Joerg
