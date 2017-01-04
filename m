From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Jan 2017 08:54:28 -0600
Subject: [PATCH v6 1/5] dt-bindings: zte: documents zx2967 power domain
 driver bindings
In-Reply-To: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
References: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170104145428.b7dqxu34gp2nwup2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 07:48:10PM +0800, Baoyou Xie wrote:
> This patch documents devicetree tree bindings for the ZTE zx2967
> power domain driver.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt b/Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
> new file mode 100644
> index 0000000..1476318
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
> @@ -0,0 +1,17 @@
> +* ZTE 2967 SoC Power Domains
> +
> +2967 processors include support for multiple power domains which are used
> +to gate power to one or more peripherals on the processor.
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx296718-pcu - for zx296718 board's power domain.

board? I'd expect this is for an SoC?

> +- reg: physical base address of the controller and length of memory mapped
> +    region.

#power-domain-cells needed?

> +
> +Example:
> +
> +	pcu_domain: pcu at 0x00117000 {

pcu at 117000

> +		compatible = "zte,zx296718-pcu";
> +		reg = <0x00117000 0x1000>;
> +	};
> -- 
> 2.7.4
> 
