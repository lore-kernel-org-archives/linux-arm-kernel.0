From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jan 2017 10:03:07 +0100
Subject: [PATCH v3 03/10] clk: sunxi-ng: rename sun8i-h3 driver to
 sunxi-h3-h5
In-Reply-To: <20170129023331.62106-4-icenowy@aosc.xyz>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-4-icenowy@aosc.xyz>
Message-ID: <20170130090307.mmeab5ybfxaeicq2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 29, 2017 at 10:33:24AM +0800, Icenowy Zheng wrote:
> As the CCU in the Allwinner H5 SoC is very similar to the one in H3,
> rename the H3 driver to sunxi-h3-h5 so that it can be extended with H5
> support.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> The original PATCH v2 3/9 is splited into two patches in v3, this one renames
> the H3 driver to h3-h5, and the next one finally add H5 support to it.
> 
>  drivers/clk/sunxi-ng/Kconfig                       |   4 +-
>  drivers/clk/sunxi-ng/Makefile                      |   2 +-
>  .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} |  42 +++---
>  .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  10 +-
>  include/dt-bindings/clock/sun8i-h3-ccu.h           | 146 +--------------------
>  include/dt-bindings/clock/sunxi-h3-h5-ccu.h        | 145 ++++++++++++++++++++
>  include/dt-bindings/reset/sun8i-h3-ccu.h           | 104 +--------------
>  include/dt-bindings/reset/sunxi-h3-h5-ccu.h        | 103 +++++++++++++++
>  8 files changed, 282 insertions(+), 274 deletions(-)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (96%)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (88%)
>  mode change 100644 => 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/clock/sunxi-h3-h5-ccu.h
>  mode change 100644 => 120000 include/dt-bindings/reset/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/reset/sunxi-h3-h5-ccu.h

Please generate your patches with -M

> -static void __init sun8i_h3_ccu_setup(struct device_node *node)
> +static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
> +				  const struct sunxi_ccu_desc *desc)
>  {

The indentation should be on the opening parenthesis.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/c21a3680/attachment.sig>
