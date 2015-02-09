From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 09 Feb 2015 14:35:14 +0100
Subject: [PATCH 01/13] clk: dts: mediatek: add Mediatek MT8135 clock
 bindings
In-Reply-To: <1423478845-2835-2-git-send-email-s.hauer@pengutronix.de>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1423488914.3716.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 09.02.2015, 11:47 +0100 schrieb Sascha Hauer:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> Document the device-tree binding of Mediatek MT8135 SoC, including
> TOPCKGEN, PLLs, INFRA and PERI clock controller.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/clock/mediatek,mt8135-clock.txt       |  44 +++++
>  include/dt-bindings/clock/mt8135-clk.h             | 190 +++++++++++++++++++++
>  2 files changed, 234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt
>  create mode 100644 include/dt-bindings/clock/mt8135-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt b/Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt
> new file mode 100644
> index 0000000..1e3566f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8135-clock.txt
> @@ -0,0 +1,44 @@
> +Mediatek MT8135 Clock Controller
> +
> +This binding uses the common clock binding:
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The Mediatek MT8135 clock controller generates and supplies clock to various
> +controllers within Mediatek MT8135 SoC.
> +
> +Required Properties:
> +
> +- compatible: should be one of following:
> +	- "mediatek,mt8135-topckgen" : for topckgen clock controller of MT8135.
> +	- "mediatek,mt8135-apmixedsys" : for apmixed_sys (PLLs) of MT8135.
> +	- "mediatek,mt8135-infracfg" : for infra_sys clock controller of MT8135.
> +	- "mediatek,mt8135-pericfg" : for peri_sys clock controller of MT8135.
> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- #clock-cells: should be 1.

After patch 3 ("clk: mediatek: Add reset controller support"), there's
another required property:

- #reset-cells: should be 1.

Patch 9 ("ARM: dts: mediatek: Enable clock support for Mediatek
MT8135.") already correctly includes these in the dtsi.

regards
Philipp
