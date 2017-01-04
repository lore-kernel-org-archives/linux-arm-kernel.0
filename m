From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Jan 2017 08:07:50 -0600
Subject: [PATCH 2/5] drivers: mmc: sunxi: limit A64 MMC2 to 8K DMA buffer
In-Reply-To: <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20170104140750.7qs4pvggwjdj5cma@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 11:03:43PM +0000, Andre Przywara wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Unlike the A64 user manual reports, the third MMC controller on the
> A64 (and the only one capable of 8-bit HS400 eMMC transfers) has a
> DMA buffer size limit of 8KB (much like the very old Allwinner SoCs).
> This does not affect the other two controllers, so introduce a new
> DT compatible string to let the driver use different settings for that
> particular device. This will also help to enable the high-speed transfer
> modes of that controller later.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
>  drivers/mmc/host/sunxi-mmc.c                        | 7 +++++++
>  2 files changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
