From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 8 Jan 2015 15:56:41 +0100
Subject: [PATCH v2 6/8] ARM: mvebu: Document the Device Tree binding for
 the Armada 388 SoC
In-Reply-To: <1420714305-7496-7-git-send-email-gregory.clement@free-electrons.com>
References: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
 <1420714305-7496-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150108155641.610488a1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu,  8 Jan 2015 11:51:43 +0100, Gregory CLEMENT wrote:
> Update the binding documentation of the Armada 38x Soc family with
> the Armada 388.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/armada-38x.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
> index ad9f8ed4d9bd..202953f1887e 100644
> --- a/Documentation/devicetree/bindings/arm/armada-38x.txt
> +++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
> @@ -15,6 +15,13 @@ Required root node property:
>  
>  compatible: must contain "marvell,armada385"
>  
> +In addition, boards using the Marvell Armada 388 SoC shall have the
> +following property before the previous one:

So before "marvell,armada385" ? So we want to have:

 compatible = "<board>", "marvell,armada388", "marvell,armada385", "marvell,armada380";

 ?

That's not what you do in the new armada-385-gp.dts. The 388 is a
superset of the 385, which itself is a superset of the 380. Should this
be reflected in this list of compatible strings?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
