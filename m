From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Nov 2015 18:32:52 +0100
Subject: [PATCH v3 3/5] clk: sunxi: Add sun9i A80 cpus (cpu special)
 clock support
In-Reply-To: <1448357536-26613-4-git-send-email-wens@csie.org>
References: <1448357536-26613-1-git-send-email-wens@csie.org>
 <1448357536-26613-4-git-send-email-wens@csie.org>
Message-ID: <20151125173252.GN32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 24, 2015 at 05:32:14PM +0800, Chen-Yu Tsai wrote:
> The "cpus" clock is the clock for the embedded processor in the A80.
> It is also part of the PRCM clock tree. This clock includes a pre-
> divider on one of its inputs. For now we are using a custom clock
> driver for it. In the future we may want to develop a generalized
> driver for these types of clocks, which also includes the AHB clock
> driver on sun[5678]i.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Maxime,
> 
> I'll do the factors clock refactoring mentioned during the discussion
> around v2 later on.

I have no idea what you are talking about :)

> 
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-sun9i-cpus.c                | 240 ++++++++++++++++++++++
>  3 files changed, 242 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index b6859ed6913f..153ac72869e8 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -27,6 +27,7 @@ Required properties:
>  	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
>  	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
>  	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
> +	"allwinner,sun9i-a80-cpus-clk" - for the CPUS on A80
>  	"allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
>  	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
>  	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index 121333ce34ea..07d914c3f6d1 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -13,6 +13,7 @@ obj-y += clk-simple-gates.o
>  obj-y += clk-sun8i-apb0.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
> +obj-y += clk-sun9i-cpus.o

Same thing here, if it's only used in the A80, just compile it when
ARCH_SUN9I is compiled.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151125/a7280ddd/attachment.sig>
