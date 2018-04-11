From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Apr 2018 14:43:25 +0200
Subject: [PATCH v4 0/8] drm/sun4i: Allwinner MIPI-DSI support
In-Reply-To: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180411124325.youvfpws27l2wesf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 11:57:08AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here is an preliminary version of the MIPI-DSI support for the Allwinner
> SoCs.
> 
> This controller can be found on a number of recent SoCs, such as the
> A31, A33 or the A64.
> 
> Given the sparse documentation, there's a number of obscure areas, but
> the current implementation has been tested with a 4-lanes DSI panel on
> an A33.
> 
> The support is a bit rough around the edges at the time, and some artifacts
> are still shown on the screen for some reasons. Wider testing with
> different display will hopefully nail those down.
> 
> This needs the regmap_mmio_attach_clk, on its way to Linus in 4.17.
> 
> Let me know what you think,
> Maxime
> 
> Changes from v3:
>   - Rebased on top of current drm-misc-next
>   - Switched to SPDX license header
>   - Made the ECC array const
>   - Split the big DSI patch into two, one to add the DSI driver and one to
>     add the TCON bits.
>   - Removed the dithering code
>   - Changed the DT labels to remove the indices
>   - Used sleeps instead of delays in the panel driver
>   - Used the backlight_enable / _disable functions
>   - Added Chen-Yu's Reviewed-by
> 
> Changes from v2:
>   - Added a ports node under the DSI node
>   - Changed the huarui panel driver to an ili9881c driver
>   - Changed the panel vendor to bananapi
>   - Made the init table static in the panel driver
>   - Dropped the huarui vendor patch for the DT doc.
> 
> Changes from v1:
>   - Rebased on 4.16-rc1
>   - Constified a few function arguments and structures
>   - Reworked the DT binding example a bit
>   - Reworked the panel driver to check for DSI return codes, and use DCS
>     helpers when possible
> 
> Maxime Ripard (8):
>   drm/sun4i: tcon: Add TRI finish interrupt for vblank
>   dt-bindings: display: Add Allwinner MIPI-DSI bindings
>   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
>   drm/sun4i: Tie the DSI controller in the TCON
>   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
>   drm/panel: Add Ilitek ILI9881c panel driver
>   ARM: dts: sun8i: a33: Add the DSI-related nodes
>   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

I just pushed the patches 1-4 and 7. I'll wait for some feedback from
Thierry for the panel driver.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180411/05bac6ce/attachment.sig>
