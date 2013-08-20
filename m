From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 09:00:39 +0200
Subject: [PATCH] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <CAHCPf3t1_5zhSOrfVFHgeVPa25sT+ewv1=OZA8X4_YZXb9cSeA@mail.gmail.com>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
 <CAHCPf3t1_5zhSOrfVFHgeVPa25sT+ewv1=OZA8X4_YZXb9cSeA@mail.gmail.com>
Message-ID: <20130820070039.GH31036@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:23:40PM -0500, Matt Sealey wrote:
> Please could you describe how the compatible property allows matching
> and covers both the ROM version *and* the distributed firmware file
> that is also referenced in the device tree for each sdma node for each
> SoC supported?

As said, we have a problem here since currently the dts references a
single firmware file in a compatible entry which covers two SoC
revisions. Both SoC revisions need a different firmware file.

> As far as I recall, the offsets for the (potentially
> buggy) on-chip version and the one in the BSP (and hopefully in
> upstream kernels at some soon-approaching version) are not the same
> for a good swath of these chips.

The patch only adds the ROM code addresses which don't change. If a ROM
script turns out to be buggy, just remove the corresponding pointer from
the driver. Even if you don't remove it, a RAM firmware file is always
able to overwrite already existing pointers.

> 
> How would the driver hope to match this up without causing some DMA
> explosions and/or invalid device trees if the BSP firmware is
> described, the BSP firmware file is not found, and the driver is left
> with the ROM version?

The driver only contains the ROM script addresses which don't change. As
said, if one turns out to be buggy, remove the correspong pointer. What
kind of DMA explosions do you envision?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
