From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 10:21:54 -0600
Subject: [PATCH 4/6] omap: iommu: intial hwmod support
In-Reply-To: <4CD5C333.8090608@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-5-git-send-email-omar.ramirez@ti.com>
	<4CD5C333.8090608@ti.com>
Message-ID: <AANLkTikMOJkgXvmC4WxPR2iiuJFO_20HjWrr6kgp3SZG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 4:05 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> ?static struct iommu_device omap3_devices[] = {
>
> You should not need that at all, you are just duplicating the data that are
> already in hwmod, and then you are going to create real platform_device.

ok, will try that.

>> ? ? ? ?for (i = 0; i< ?num_iommu_devices; i++) {
>
> Don't do that, just iterate over the hwmod class using
> omap_hwmod_for_each_by_class. Please have a look at the drivers with
> multiple devices that are already using hwmod (i2c, uart...).

And this too.

Regards,

Omar
