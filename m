From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 18:57:46 +0100
Subject: [PATCH 2/5] drivers: mmc: sunxi: limit A64 MMC2 to 8K DMA buffer
In-Reply-To: <20170104140750.7qs4pvggwjdj5cma@rob-hp-laptop>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
 <20170104140750.7qs4pvggwjdj5cma@rob-hp-laptop>
Message-ID: <20170105175746.fq6crpc3krz7tzxi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Jan 04, 2017 at 08:07:50AM -0600, Rob Herring wrote:
> On Mon, Jan 02, 2017 at 11:03:43PM +0000, Andre Przywara wrote:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > Unlike the A64 user manual reports, the third MMC controller on the
> > A64 (and the only one capable of 8-bit HS400 eMMC transfers) has a
> > DMA buffer size limit of 8KB (much like the very old Allwinner SoCs).
> > This does not affect the other two controllers, so introduce a new
> > DT compatible string to let the driver use different settings for that
> > particular device. This will also help to enable the high-speed transfer
> > modes of that controller later.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
> >  drivers/mmc/host/sunxi-mmc.c                        | 7 +++++++
> >  2 files changed, 8 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Some kind of a digression on this: we have three MMC controllers on
this SoC. Like this patch shows, the third one is clearly different,
and supports both more modes, a wider bus, and specific quirks. We
need a new compatible for this one, everything's perfect.

However, the other two are mostly the same, but seems to need
different tuning parameters to get more performances out of the
controller (but this is unclear yet). How do we usually deal with
that?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/6d02f07c/attachment.sig>
