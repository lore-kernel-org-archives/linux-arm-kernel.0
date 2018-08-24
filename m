From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 24 Aug 2018 20:08:22 +0200
Subject: [PATCH v2 0/4] iommu/rockchip: Runtime PM fixes
In-Reply-To: <20180824155059.qskwdxmc6ws3hwtv@localhost>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
 <20180824155059.qskwdxmc6ws3hwtv@localhost>
Message-ID: <13492452.cxnNOAAFxb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 24. August 2018, 17:50:59 CEST schrieb Olof Johansson:
> On Fri, Aug 24, 2018 at 04:06:33PM +0100, Marc Zyngier wrote:
> > This small series addresses a couple of runtime PM issues I've spotted
> > while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
> > specifically doing kexec.
> > 
> > In order to avoid making a complete mess of the IOMMU code, Heiko has
> > requested that all RK platforms would select CONFIG_PM, which
> > simplifies a lot of things. I've kept 32 and 64bit patches separate,
> > but feel free to squash them into on if that's more convenient.
> > 
> > Note that even with these patches, kexec is still fairly broken on
> > rk3399, as the VOP is never turned off (see [1] for a fix).
> > 
> > [1] https://www.spinics.net/lists/arm-kernel/msg670229.html
> > 
> > * From v1:
> >   - Collected RBs from Heiko
> >   - Added two patches forcing CONFIG_PM on all Rockchip platforms at
> >     Heiko's request, following the example set by Tegra platforms.
> 
> Thanks, applied to our next/late branch which I plan to send in tomorrow.

that was a quick turn around :-) .
Thanks for picking the series.

Heiko
