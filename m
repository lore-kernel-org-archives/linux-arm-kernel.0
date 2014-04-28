From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:36:29 -0700
Subject: [PATCH v9 03/17] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <1398507381-5614-4-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20140428193629.GI3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 12:16:07PM +0200, Hans de Goede wrote:
> From: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> 
> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
> designware idmac controller, which is identical to the one found in the mmc-dw
> hosts. However the rest of the host is not identical to mmc-dw, it deals with
> sending stop commands in hardware which makes it significantly different
> from the mmc-dw devices.
> 
> HdG: Various cleanups and fixes.
> 
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/mmc/sunxi-mmc.txt          |   43 +
>  drivers/mmc/host/Kconfig                           |    7 +
>  drivers/mmc/host/Makefile                          |    2 +
>  drivers/mmc/host/sunxi-mmc.c                       | 1125 ++++++++++++++++++++
>  4 files changed, 1177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>  create mode 100644 drivers/mmc/host/sunxi-mmc.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> new file mode 100644
> index 0000000..f0c06e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -0,0 +1,43 @@
> +* Allwinner sunxi MMC controller
> +
> +The highspeed MMC host controller on Allwinner SoCs provides an interface
> +for MMC, SD and SDIO types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.5 as well
> +as the speed of SD standard 3.0.
> +Absolute maximum transfer rate is 200MB/s
> +
> +Required properties:
> + - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
> + - reg : mmc controller base registers
> + - clocks : a list with 2 phandle + clock specifier pairs
> + - clock-names : must contain "ahb" and "mod"

Again, this is not a module0 clock, so the clock name is misleading.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/9657d53b/attachment.sig>
