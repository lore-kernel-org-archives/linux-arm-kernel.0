From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 9 May 2016 09:39:58 +0200
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160509093958.26e9549f8ce78888c0e9586a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  8 May 2016 22:01:50 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Add the list of clocks and resets found in the H3 CCU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile        |   2 +
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 757 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
>  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
>  4 files changed, 1024 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
>  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index c794f57b6fb1..67ff6a92f124 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -13,3 +13,5 @@ obj-y += ccu_nkmp.o
>  obj-y += ccu_nm.o
>  obj-y += ccu_p.o
>  obj-y += ccu_phase.o
> +
> +obj-y += ccu-sun8i-h3.o

+obj-$(CONFIG_MACH_SUN8I) += ccu-sun8i-h3.o

should be better.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
