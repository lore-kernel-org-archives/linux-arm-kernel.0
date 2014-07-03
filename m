From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Jul 2014 23:01:47 +0200
Subject: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
In-Reply-To: <53B5C3C2.6080501@free-electrons.com>
References: <20140703135146.GA6898@luxor.wired.org>
 <20140703162759.3909592a@free-electrons.com>
 <53B5BB85.2070900@free-electrons.com>
 <20140703225244.50378fa4@free-electrons.com>
 <53B5C3C2.6080501@free-electrons.com>
Message-ID: <20140703230147.1007a41e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

If you have touched the OMAP IOMMU driver recently, please read on.

On Thu, 03 Jul 2014 22:57:38 +0200, Gregory CLEMENT wrote:

> > So it calls bus_set_iommu() unconditionally, without caring at all
> > whether it is running on a platform that actually cares about OMAP
> > IOMMU. And then later on, a bus notifier of the IOMMU subsystem gets
> > called, and some NULL pointer gets dereferenced. I'm pretty sure that
> > if you comment out this subsys_initcall(), you won't see the problem
> > anymore.
> 
> Indeed I comment it, and I didn't see the problem anymore.
> 
> > However, this code has been around since a while, so I don't know if
> > it's actually the change that makes it visible. Maybe some other IOMMU
> > core internal change makes it actually visible. But this
> > subsys_initcall() that does random stuff without caring about the
> > platform it runs on anyway looks incorrect.
> 
> I think that nobody until now have run this configuration.

Hum, indeed, I was assuming multi_v7_defconfig would have that enabled,
but it only has the Tegra IOMMU enabled, and not the OMAP IOMMU one.

So, the bug clearly belongs to the developers of the OMAP IOMMU driver,
so I've added a bunch of people who touched this driver recently in Cc.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
