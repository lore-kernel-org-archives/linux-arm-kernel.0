From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 11:16:41 +0200
Subject: [PATCH v4 00/11] drm: sun4i: Add support for the HDMI controller
In-Reply-To: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170529091641.5psbm7lvgvgob26o@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 06:09:25PM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here is an attempt at getting the HDMI controller running.
> 
> This HDMI controller is found on a number of old Allwinner SoCs (A10, A10s,
> A20, A31).
> 
> This driver only supports for now the A10s because it was an easy target,
> being very close to the A13 that is already supported by our DRM driver.
> 
> There's nothing out of the extraordinary there, except maybe the clock
> setup. All the internal clocks (TMDS, DDC) have been modeled using the
> common clock framework, the TMDS clock being the parent of the DDC one.
> 
> While this might sound overkill, other SoC have a different, external
> source for the DDC clock, which will be easier to support through the clock
> framework.
> 
> The IP also supports audio (through an already supported i2s controller,
> and some missing configuration in the HDMI controller) and CEC. Both will
> come eventually.

Applied all the patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/6bd44169/attachment.sig>
