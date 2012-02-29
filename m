From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 08:58:49 -0800
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229122942.GF3318@game.jcrosoft.org>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Christophe PLAGNIOL-VILLARD wrote at Wednesday, February 29, 2012 5:30 AM:
> On 17:03 Tue 28 Feb     , Stephen Warren wrote:
> > uImage files typically encode a single absolute load and entry address.
> > This is inconvenient when attempting to share that uImage across multiple
> > SoCs with different physical RAM addresses. Recent versions of mkimage
> > implement a "kernel_noload" image type which encodes no absolute load
> > address, and a relative entry address. This works well for uImage-wrapped
> > ARM zImages, since they are relocatable.
> >
> > This is enabled by commit b9b50e89d317c58becd0e2d7fac2e21e3a81dd0a
> > "image: Implement IH_TYPE_KERNEL_NOLOAD" in U-Boot.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > I assume I should put this into the ARM patch tracker if it's OK?
>
> Again a new option for uImage no why not just boot the zImage
> 
> in this case the uImage is useless

U-Boot doesn't support zImage at present.

A patch was posted to support it at least for ARM, but needed a little
work before it could be committed.

-- 
nvpublic
