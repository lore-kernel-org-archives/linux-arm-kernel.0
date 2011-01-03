From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 3 Jan 2011 16:42:14 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110103154214.GB11033@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 11:48:41AM +0100, Sascha Hauer wrote:
> The IPU is the Image Processing Unit found on i.MX50/51/53 SoCs. It
> features several units for image processing, this patch adds support
> for the units needed for Framebuffer support, namely:
>
> - Display Controller (dc)
> - Display Interface (di)
> - Display Multi Fifo Controller (dmfc)
> - Display Processor (dp)
> - Image DMA Controller (idmac)
>
> This patch is based on the Freescale driver, but follows a different
> approach. The Freescale code implements logical idmac channels and
> the handling of the subunits is hidden in common idmac code pathes
> in big switch/case statements. This patch instead just provides code
> and resource management for the different subunits. The user, in this
> case the framebuffer driver, decides how the different units play
> together.
>
> The IPU has other units missing in this patch:
>
> - CMOS Sensor Interface (csi)
> - Video Deinterlacer (vdi)
> - Sensor Multi FIFO Controler (smfc)
> - Image Converter (ic)
> - Image Rotator (irt)
>
> So expect more files to come in this directory.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Hello Samuel,

I see no further comments on this series. Does this mean you are ok with
the patch or didn't you find the time looking at it?

This patch can go via the mfd tree or I can push this via my i.MX tree.
Going via the i.MX tree makes life a bit easier for me because we do not
run into merge order dependencies. Please let me know what you prefer.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
