From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 16:53:55 +0100
Subject: [PATCH v2 3/9] clk: sunxi-ng: add support for Allwinner H5 SoC
In-Reply-To: <20170126154859.55855-4-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-4-icenowy@aosc.xyz>
Message-ID: <20170127155355.zu6k7ucbpewmlsjb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48:53PM +0800, Icenowy Zheng wrote:
> Allwinner H5 is a SoC that features a CCU like H3, but with MMC phase
> clocks removed (for new MMC controller) and a new bus gate/reset
> imported.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> A giant rewrite since v1.
> It now do not use a dedicated driver for H5, but altered the CCU driver
> of H3 to support H5.
> 
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>  drivers/clk/sunxi-ng/Kconfig                       |   6 +-
>  drivers/clk/sunxi-ng/Makefile                      |   2 +-
>  .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 179 ++++++++++++++++++---
>  .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  15 +-
>  include/dt-bindings/clock/sun8i-h3-ccu.h           | 146 +----------------
>  include/dt-bindings/clock/sunxi-h3-h5-ccu.h        | 148 +++++++++++++++++
>  include/dt-bindings/reset/sun8i-h3-ccu.h           | 104 +-----------
>  include/dt-bindings/reset/sunxi-h3-h5-ccu.h        | 106 ++++++++++++
>  9 files changed, 431 insertions(+), 276 deletions(-)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (80%)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (82%)
>  mode change 100644 => 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/clock/sunxi-h3-h5-ccu.h
>  mode change 100644 => 120000 include/dt-bindings/reset/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/reset/sunxi-h3-h5-ccu.h

Please do that in two patches. One to rename the existing driver, one
to support the H5.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/342fb7e9/attachment.sig>
