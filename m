From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 12 Jan 2017 04:47:04 +0100
Subject: [PATCH 3/4] dt-bindings: power/supply: Update TPS65217 properties
In-Reply-To: <20161209062833.5768-4-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-4-woogyom.kim@gmail.com>
Message-ID: <20170112034704.4lgilyic5cj4nrxs@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milo,

On Fri, Dec 09, 2016 at 03:28:32PM +0900, Milo Kim wrote:
> Add interrupt specifiers for USB and AC charger input. Interrupt numbers
> are from the datasheet.
> Fix wrong property for compatible string.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> index 98d131a..a11072c 100644
> --- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> @@ -2,11 +2,16 @@ TPS65217 Charger
>  
>  Required Properties:
>  -compatible: "ti,tps65217-charger"
> +-interrupts: TPS65217 interrupt numbers for the AC and USB charger input change.
> +             Should be <0> for the USB charger and <1> for the AC adapter.
> +-interrupt-names: Should be "USB" and "AC"
>  
>  This node is a subnode of the tps65217 PMIC.
>  
>  Example:
>  
>  	tps65217-charger {
> -		compatible = "ti,tps65090-charger";
> +		compatible = "ti,tps65217-charger";
> +		interrupts = <0>, <1>;
> +		interrupt-names = "USB", "AC";
>  	};

Thanks, I queued this into power-supply's for-next branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/bcf82b7e/attachment.sig>
