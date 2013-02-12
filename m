From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Feb 2013 09:11:57 -0800
Subject: [PATCH] ARM: OMAP2+: fix some omap_device_build() calls that
 aren't compiled by default
In-Reply-To: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com>
Message-ID: <20130212171156.GH4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130211 20:02]:
> 
> Commit c1d1cd597fc77af3086470f8627d77f52f7f8b6c ("ARM: OMAP2+:
> omap_device: remove obsolete pm_lats and early_device code") missed a
> few omap_device_build() calls that aren't included as part of the default
> OMAP2+ Kconfig, omap2plus_defconfig.
> 
> Ideally, all devices that are present on the SoC should be created by
> default, and only the corresponding device driver should be configured
> or deconfigured in Kconfig.  This allows drivers to be built as
> modules and loaded later, even if they weren't part of the original
> kernel build.  Unfortunately, we're not quite there yet.
> 
> Thanks to Tony Lindgren for reporting this, found during his
> randconfig tests.

Thanks, I'll apply this into omap-for-v3.9/pm-wfi as the breaking
commit is already in arm-soc/for-next.

Tony
