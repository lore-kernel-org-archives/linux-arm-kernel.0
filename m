From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Oct 2017 10:00:56 +0200
Subject: [PATCH v4 00/11] drm/sun4i: hdmi: Support HDMI controller on A31
In-Reply-To: <20171010032008.682-1-wens@csie.org>
References: <20171010032008.682-1-wens@csie.org>
Message-ID: <20171011080056.i2eodfsujdhcvxpi@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 03:19:57AM +0000, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v4 of my A31 HDMI support series. The DTS patches depend on
> the patch "clk: sunxi-ng: sun6i: Export video PLLs" alreay merged.
> The DRM patches depend on "regmap: add iopoll-like polling macro for
> regmap_field" already merged on a topic branch in the regmap repository.
> 
> Changes since v3:
> 
>     - Renamed sun4i_get_first_tcon() to sun4i_get_tcon0()
> 
>     - Made sun4i_get_tcon0() return NULL when it fails, and
>       sun6i_tcon_set_mux() will error out if that happens.
> 
>     - Removed has_unknown_mux field in tcon_quirks structure,
>       as its function is replaced by the per-soc muxing function
>       pointer.
> 
>     - Dropped clk and regmap patches that were merged.
> 
> Changes since v2:
> 
>     - TCON muxing moved into functions for each platform, with pointers
>       to them in the TCON quirks structure.
> 
>     - CCU "hdmi-ddc" clock renamed to "ddc".
> 
>     - Added Maxime's acks.
> 
> Changes since v1:
> 
>     - Core changes to sun4i-drm to support two display pipelines
>       have been merged into drm-misc and thus dropped from this
>       version
> 
>     - Reworked DDC variant support onto new exposed I2C interface bits.
> 
>     - Reworked DDC variant support to use regmap_fields.
> 
>     - Patches to add variant support to various (TMDS, DDC, HDMI
>       controller) sub-blocks have been merged into one patch.
> 
> This series adds support for the HDMI controller found on Allwinner
> A31/A31s SoCs. It builds upon Maxime's work that added support for
> the HDMI controller on the Allwinner A10s SoC.
> 
> The HDMI controllers in the older generation Allwinner SoCs is very
> similar. The A10/A10s/A20 all have the same hardware block, with the
> A10 having slightly different initial configuration values. The A31's
> variant splits out the DDC parent clock, has different formulas for
> the DDC and TMDS clocks, and a different register layout for the DDC
> block.

Applied everything, thanks!

> Also, it does not expose the CEC pins outside of the SoC, which is
> unfortunate.

Maybe we shouldn't register the CEC adapter in that case then? Can you
send an additional patch for that?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171011/455d43d2/attachment-0001.sig>
