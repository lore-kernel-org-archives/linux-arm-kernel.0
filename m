From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 22 Mar 2017 09:01:37 +0100
Subject: [PATCH 01/15] ARM: dts: alpine: fix PCIe node name
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322080137.st3osq5ckfis6uwz@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Mar 21, 2017 at 09:02:59PM -0500, Rob Herring wrote:
> PCIe bridges should have a node name of 'pcie'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

This can go through arm-soc directly. If not I'll take it.
Thanks!

Antoine

> Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.
> 
>  arch/arm/boot/dts/alpine.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
> index d0eefc3b886c..f09f9c8e178a 100644
> --- a/arch/arm/boot/dts/alpine.dtsi
> +++ b/arch/arm/boot/dts/alpine.dtsi
> @@ -139,7 +139,7 @@
>  		};
>  
>  		/* Internal PCIe Controller */
> -		pcie-internal at 0xfbc00000 {
> +		pcie at fbc00000 {
>  			compatible = "pci-host-ecam-generic";
>  			device_type = "pci";
>  			#size-cells = <2>;
> -- 
> 2.10.1
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/01ad26da/attachment.sig>
