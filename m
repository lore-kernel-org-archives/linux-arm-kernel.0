From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 19 Sep 2018 11:32:49 +0200
Subject: [PATCH v2 0/4] Fix A64/R40 HDMI PHY device tree binding
In-Reply-To: <20180916043409.62374-1-icenowy@aosc.io>
References: <20180916043409.62374-1-icenowy@aosc.io>
Message-ID: <20180919093249.lkjoaki6bi6ieyht@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 16, 2018 at 12:34:05PM +0800, Icenowy Zheng wrote:
> When adding support for A64 HDMI PHY in 4.19, we assumed that the two
> PLL-VIDEOs can both feed the HDMI PHY clock. However experiments show
> that the mux bit discovered in R40 blob is not applicable on A64. This
> is not discovered, as normally with a single display pipeline only
> PLL-VIDEO0 will be used.
> 
> In this patchset the second PLL is dropped, and a binding specially for
> R40 HDMI PHY is added (which seems to have the mux).
> 
> PATCH 1 is dropping second PLL for A64 HDMI PHY, and PATCH 2 to 4
> are adding R40 HDMI PHY binding, as R40 behaves differently with A64
> with this.
> 
> This patchset targets v4.19 fixes tree, because the binding is
> introduced in v4.19, and if we don't fix it there a wrong binding will
> be left in a stable version released. A64 display pipeline support is
> not yet in v4.19, but R40 support is in it.

Applied 1 and 4 as fixes for 4.19, 2 and 3 for 4.20, since they are
not fixes per se, and the R40 display engine is not enabled in 4.19
anyway.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/20ad0585/attachment.sig>
