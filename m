From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jan 2016 11:32:29 +0100
Subject: [PATCH] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453888578.28646.7.camel@mtksdaap41>
References: <201601271708.gQUxXACW%fengguang.wu@intel.com>
 <4711589.Ig064LES4c@wuerfel> <1453888578.28646.7.camel@mtksdaap41>
Message-ID: <6167008.u8jfFpmfhy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 January 2016 17:56:18 James Liao wrote:
> > 
> > I think you should include this change in your patch, or as a preparation.
> > All other samsung platforms already select COMMON_CLK through ARCH_MULTIPLATFORM,
> > and all SoCs that are part of ARCH_S3C24XX individually select a symbol that
> > selects COMMON_CLK.
> 
> Oops, I didn't notice there are warnings after moving these Kconfigs
> into menu section.
> 
> The original motivation of this patch is preventing new clk drivers
> include their Kconfig in a wrong place, so it's not critical. Do you
> think we should apply this patch (with your changes below) or drop this
> patch directly?


I think your patch is good, we just need to fix S3C24xx, which is doing
things in a strange way for historic reasons.

	Arnd
