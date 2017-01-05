From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 5 Jan 2017 14:46:53 +0800
Subject: [PATCH v6 1/5] dt-bindings: zte: documents zx2967 power domain
 driver bindings
In-Reply-To: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
References: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170105064651.GA4667@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 07:48:10PM +0800, Baoyou Xie wrote:
> This patch documents devicetree tree bindings for the ZTE zx2967

'devicetree' is good enough, and the 'tree' after it is redundant.

> power domain driver.

DT bindings is to describe hardware block not software, so the word like
'driver' is not appropriate.  So please drop it from here and the patch
subject.

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

ZTE ZX2967 family.  And this is a bindings document for PCU, IMO.  And
do we know the full name of abbreviation 'PCU'?  Power Control Unit?

> +
> +2967 processors include support for multiple power domains which are used

ZX2967 family

> +to gate power to one or more peripherals on the processor.
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx296718-pcu - for zx296718 board's power domain.

Drop 'board's'.

> +- reg: physical base address of the controller and length of memory mapped
> +    region.
> +
> +Example:
> +
> +	pcu_domain: pcu at 0x00117000 {

The unit-address in node name shouldn't have 0x and leading zeros.

	pcu_domain: pcu at 117000 {

Shawn

> +		compatible = "zte,zx296718-pcu";
> +		reg = <0x00117000 0x1000>;
> +	};
> -- 
> 2.7.4
> 
