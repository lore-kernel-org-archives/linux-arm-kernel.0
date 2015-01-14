From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 17:37:57 +0100
Subject: [PATCH v3 04/13] clk: sunxi: Add driver for A80 MMC config
 clocks/resets
In-Reply-To: <1421113055-17867-5-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-5-git-send-email-wens@csie.org>
Message-ID: <20150114163757.GZ4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 09:37:26AM +0800, Chen-Yu Tsai wrote:
> On the A80 SoC, the 4 mmc controllers each have a separate register
> controlling their register access clocks and reset controls. These
> registers in turn share a ahb clock gate and reset control.
> 
> This patch adds a platform device driver for these controls. It
> requires both clocks and reset controls to be available, so using
> CLK_OF_DECLARE might not be the best way.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  25 ++-
>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-sun9i-mmc.c                 | 222 ++++++++++++++++++++++
>  3 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/sunxi/clk-sun9i-mmc.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 0dfd018ba47b..60b44285250d 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -57,6 +57,7 @@ Required properties:
>  	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
>  	"allwinner,sun4i-a10-mmc-clk" - for the MMC clock
>  	"allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
> +	"allwinner,sun9i-a80-mmc-config-clk" - for mmc gates + resets on A80

It looks like it's not just a clock. How about dropping the -clk
suffix?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/69f80c0d/attachment.sig>
