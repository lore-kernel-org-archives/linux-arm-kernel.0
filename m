From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Sep 2017 17:02:30 -0500
Subject: [PATCH 1/7] dt-bindings: gpu: mali-utgard: Add Rockchip Utgard
 Malis
In-Reply-To: <20170905105739.8330-2-heiko@sntech.de>
References: <20170905105739.8330-1-heiko@sntech.de>
 <20170905105739.8330-2-heiko@sntech.de>
Message-ID: <20170912220230.kegayoedm4olybat@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 12:57:33PM +0200, Heiko Stuebner wrote:
> Some (older or lower power) Rockchip socs use Utgard-based Mali-GPUs.
> So add the necessary compatibles for them. As the setup is the same for
> all of them (needing only the additional reset line), they get added in
> a somewhat condensed form, to not inflate the document unnecessary.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index 2b6243e730f6..3b7f6f72f032 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -58,6 +58,13 @@ to specify one more vendor-specific compatible, among:
>      Required properties:
>        * resets: phandle to the reset line for the GPU
>  
> +  - rockchip,rk3036-mali
> +  - rockchip,rk3066-mali
> +  - rockchip,rk3188-mali
> +  - rockchip,rk3228-mali

Need to list the compatibles in the compatible property section. You can 
say "Rockchip variants" or something here.

> +    Required properties:
> +      * resets: phandle to the reset line for the GPU
> +
>    - stericsson,db8500-mali
>      Required properties:
>        * interrupt-names and interrupts:
> -- 
> 2.14.1
> 
