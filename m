From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:02:25 -0500
Subject: [PATCH v2 01/17] dt-bindings: power: reset: mt6323: add bindings
 for MT6323 power controller
In-Reply-To: <0b3123e42c8a47e3fa8b21aa2e139e6d3dc69f41.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
 <0b3123e42c8a47e3fa8b21aa2e139e6d3dc69f41.1524646231.git.sean.wang@mediatek.com>
Message-ID: <20180427200225.lq63ex7eiukc6egl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 05:32:27PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Adding device-tree binding for the power controller which is a tiny
> circuit block present as a part of MT6323 PMIC and is responsible for
> externally powering off or on a remote SoC the PMIC is connected to.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/power/reset/mt6323-poweroff.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> new file mode 100644
> index 0000000..6f7c590
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> @@ -0,0 +1,20 @@
> +Device Tree Bindings for Power Controller on MediaTek PMIC
> +
> +The power controller which could be found on PMIC is responsible for externally
> +powering off or on the remote MediaTek SoC through the circuit BBPU.
> +
> +Required properties:
> +- compatible: Should be one of follows
> +	"mediatek,mt6323-pwrc": for MT6323 PMIC
> +
> +Example:
> +
> +	pmic {
> +		compatible = "mediatek,mt6323";
> +
> +		...
> +
> +		power-controller {
> +			compatible = "mediatek,mt6323-pwrc";

Why do you need this in DT? It doesn't define any resources. The parent 
can just as well register a reset or poweroff handler.

Rob

> +		};
> +	}
> -- 
> 2.7.4
> 
