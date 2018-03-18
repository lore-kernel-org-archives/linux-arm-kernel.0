From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sun, 18 Mar 2018 22:31:29 +0100
Subject: [PATCH net-next 02/12] clk: sunxi-ng: r40: export a regmap to
 access the GMAC register
In-Reply-To: <20180317092857.4396-3-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-3-wens@csie.org>
Message-ID: <20180318213129.ucwslzvwq6khxrcd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 05:28:47PM +0800, Chen-Yu Tsai wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> There's a GMAC configuration register, which exists on A64/A83T/H3/H5 in
> the syscon part, in the CCU of R40 SoC.
> 
> Export a regmap of the CCU.
> 
> Read access is not restricted to all registers, but only the GMAC
> register is allowed to be written.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Gah, this is crazy. I'm really starting to regret letting that syscon
in in the first place...

And I'm not really looking forward the time where SCPI et al. will be
mature and we'll have the clock controller completely outside of our
control.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/d5df7059/attachment.sig>
