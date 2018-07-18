From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 18 Jul 2018 14:44:48 +0200
Subject: [PATCH v3 00/18] arm64: allwinner: Add A64 DE2 HDMI support
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Message-ID: <20180718124448.2s2b3jxbsqt46cgu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 04:24:40PM +0530, Jagan Teki wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.
> 
> A64 behaviour similar to Allwinner A83T where
> Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
> Mixer1 => TCON1 => HDMI
> as per Display System Block Diagram from Allwinner_A64_User_Manual_V1.1.pdf
> 
> This is third patch-set followed with previous RFC[1], first and second
> series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
> rest will add eventually.
> 
> This series fixed previous version comments
> - Rebasing on linux-next
> - sqash all pipeline components in one patch
> - Enable all pipeline components in board dts
> - about documenting fallback compatibles
> - adding new compatible for mixer1

You still haven't figured out the SRAM parts. We asked you to fix this
in the v1 and the v2 already, and we're not going to merge this
without those bits figured out properly.

> Log:
> [    1.450984] Jagan: sun8i_mixer_probe
> [    1.464981] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops)
> [    1.472572] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops)
> [    1.480676] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to regulator.10
> [    1.488738] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
> [    1.498879] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
> [    1.507372] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops)
> [    1.514778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    1.521398] [drm] No driver support for vblank timestamp query.
> [    1.684611] random: fast init done
> [    2.011575] Console: switching to colour frame buffer device 180x56
> [    2.049858] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
> [    2.057268] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
> 
> Note:
> Pine64 boards are unable to get edid by default like other A64 boards,
> but forcing 'video=HDMI-A-1:1920x1080 at 60D' kernel command line can
> create edid with display on penel

Then that needs to be figured out before it's enabled, instead of
having a hack that barely works.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/bc5695fe/attachment.sig>
