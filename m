From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Mar 2016 11:53:19 -0600
Subject: [RESPIN 1/6] dt-bindings: EXYNOS: Add exynos-srom device tree
 binding
In-Reply-To: <1456389222-12738-2-git-send-email-pankaj.dubey@samsung.com>
References: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
 <1456389222-12738-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20160302175319.GA11155@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 02:03:37PM +0530, Pankaj Dubey wrote:
> This patch adds exynos-srom binding information for SROM Controller
> driver on Exynos SoCs.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
> CC: devicetree at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  .../devicetree/bindings/memory-controllers/exynos-srom.txt   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
> new file mode 100644
> index 0000000..33886d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
> @@ -0,0 +1,12 @@
> +SAMSUNG Exynos SoCs SROM Controller driver.
> +
> +Required properties:
> +- compatible : Should contain "samsung,exynos-srom".

There should be SoC specific compatible strings in addition to this.

> +
> +- reg: offset and length of the register set
> +
> +Example:
> +	sromc at 12570000 {

This should be memory-controller at ...

> +		compatible = "samsung,exynos-srom";
> +		reg = <0x12570000 0x10>;

The next patch changes the size to 0x14?

BTW, you could just combine both patches. I guess you didn't to maintain 
authorship?

Rob
