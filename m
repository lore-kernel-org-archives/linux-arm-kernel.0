From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 09:43:39 +0200
Subject: [PATCH] ARM: dts: sunxi: libretech-all-h3-cc: Enable eMMC module
In-Reply-To: <20180712030417.15881-1-wens@csie.org>
References: <20180712030417.15881-1-wens@csie.org>
Message-ID: <20180712074339.qizqbfyhsug2pe4g@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 11:04:17AM +0800, Chen-Yu Tsai wrote:
> The Libretech ALL-H3-CC has a high density connector for attaching
> an eMMC module. The module form factor and connection is specific
> to Libretech, and has provisions for split vmmc/vqmmc (core and I/O)
> voltage supplies, but this board does not wire the vqmmc side. The
> H2+/H3/H5 SoCs do not support alternate I/O voltages for eMMC either.
> Only 3.3V is supported. A specific module that ties vqmmc to vmmc,
> with both at 3.3V, must be used.
> 
> Given that a) eMMC is not designed to be hotplugged, b) power is
> always provided on the pins, and c) MMC controllers can deal with
> missing cards, we can enable this by default. If a module is attached
> it will be picked up by the system.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/c4ca575a/attachment-0001.sig>
