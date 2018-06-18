From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 18 Jun 2018 10:27:06 +0200
Subject: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
In-Reply-To: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180618082706.jjklq36jeu3nqs2q@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 10:16:47AM +0200, Paul Kocialkowski wrote:
> This reverts commit 2c17a4368aad2b88b68e4390c819e226cf320f70.
> 
> The offending commit triggers a run-time fault when accessing the panel
> element of the sun4i_tcon structure when no such panel is attached.
> 
> It was apparently assumed in said commit that a panel is always used with
> the TCON. Although it is often the case, this is not always true.
> For instance a bridge might be used instead of a panel.
> 
> This issue was discovered using an A13-OLinuXino, that uses the TCON
> in RGB mode for a simple DAC-based VGA bridge.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/9bd97802/attachment.sig>
