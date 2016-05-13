From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 14:57:24 -0700
Subject: [PATCH v2 1/2] ARM64: dts: rockchip: add sdhci/emmc for rk3399
In-Reply-To: <5607915.FAWxOoA1QB@phil>
References: <1463092552-60696-1-git-send-email-briannorris@chromium.org>
 <5607915.FAWxOoA1QB@phil>
Message-ID: <20160513215724.GB109473@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 11:47:57PM +0200, Heiko Stuebner wrote:
> Am Donnerstag, 12. Mai 2016, 15:35:51 schrieb Brian Norris:
> > Add description for the SDHCI v5.1 eMMC controller on rk3399. Fix it to
> > 200 MHz, to support all supported timing modes.
> > 
> > Note that 'rockchip,rk3399-sdhci-5.1' is not documented; we presumably
> > have a compliant Arasan controller, but let's have a rockchip property
> > as the canonical backup/precautionary measure. Per Heiko's previous
> > suggestion, let's not clutter the arasan doc with it.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> At least one split is necessary.
> So please at least split out the simple-mfd addition into a separate patch

Will do.

BTW, should this be noted in
Documentation/devicetree/bindings/soc/rockchip/grf.txt now?

> (I should've seen that in v1 already, but sadly didn't)

No problem.

> I'm undecided if the emmc-phy addition also should get its own patch, but I 
> guess it can stay together with the emmc controller.

I think it makes sense for them to stay together. What's a phy without a
controller to use it? :)

Brian
