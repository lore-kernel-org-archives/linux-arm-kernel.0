From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Mar 2016 11:12:45 -0600
Subject: [PATCH] dt-bindings: interrupt-controller: add SoC-specific
 compatible string to Marvell ODMI
In-Reply-To: <1456327494-31358-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456327494-31358-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160302171245.GA25012@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 04:24:54PM +0100, Thomas Petazzoni wrote:
> As requested by Rob Herring, this commit adds a SoC-specific
> compatible string to the Marvell ODMI DT binding.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This commit applies on top of the Marvell ODMI driver patch, which has
> already been merged.
> ---
>  .../bindings/interrupt-controller/marvell,odmi-controller.txt      | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I see this is already merged, but for the record:

Acked-by: Rob Herring <robh@kernel.org>

There is a typo in the example though.

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> index 252d5c9..8af0a8e 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> @@ -6,7 +6,9 @@ which can be used by on-board peripheral for MSI interrupts.
>  
>  Required properties:
>  
> -- compatible           : The value here should contain "marvell,odmi-controller".
> +- compatible           : The value here should contain:
> +
> +    "marvell,ap806-odmi-controller", "marvell,odmi-controller".
>  
>  - interrupt,controller : Identifies the node as an interrupt controller.
>  
> @@ -29,7 +31,8 @@ Required properties:
>  Example:
>  
>  	odmi: odmi at 300000 {
> -		compatible = "marvell,odmi-controller";
> +		compatible = "marvell,ap806-odm-controller",

s/odm/odmi/

> +			     "marvell,odmi-controller";
>  		interrupt-controller;
>  		msi-controller;
>  		marvell,odmi-frames = <4>;
> -- 
> 2.6.4
> 
