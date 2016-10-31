From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 01:20:35 -0500
Subject: [PATCH v2 3/6] Documentation: devicetree: net: add NS2 bindings
 to amac
In-Reply-To: <1477688219-3871-4-git-send-email-jon.mason@broadcom.com>
References: <1477688219-3871-1-git-send-email-jon.mason@broadcom.com>
 <1477688219-3871-4-git-send-email-jon.mason@broadcom.com>
Message-ID: <20161031062035.5hzolwhjnwcs72kg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 04:56:56PM -0400, Jon Mason wrote:
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/brcm,amac.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,amac.txt b/Documentation/devicetree/bindings/net/brcm,amac.txt
> index ba5ecc1..f2b194e 100644
> --- a/Documentation/devicetree/bindings/net/brcm,amac.txt
> +++ b/Documentation/devicetree/bindings/net/brcm,amac.txt
> @@ -2,11 +2,12 @@ Broadcom AMAC Ethernet Controller Device Tree Bindings
>  -------------------------------------------------------------
>  
>  Required properties:
> - - compatible:	"brcm,amac" or "brcm,nsp-amac"
> + - compatible:	"brcm,amac", "brcm,nsp-amac", or "brcm,ns2-amac"

One per line is preferred.

>   - reg:		Address and length of the GMAC registers,
>  		Address and length of the GMAC IDM registers
> +		Address and length of the NIC Port Manager registers (optional)
>   - reg-names:	Names of the registers.  Must have both "amac_base" and
> -		"idm_base"
> +		"idm_base". "nicpm_base" is optional (required for NS2)

Is nicpm_base optional on some SoCs? If not just say which ones it 
applies to. A separate line will make that clearer.

_base is kind of redundant too, but it's already done.

>   - interrupts:	Interrupt number
>  
>  Optional properties:
> -- 
> 2.7.4
> 
