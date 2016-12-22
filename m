From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Dec 2016 12:45:14 -0600
Subject: [PATCH v3 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
In-Reply-To: <1482139554-13618-2-git-send-email-jerry.huang@nxp.com>
References: <1482139554-13618-1-git-send-email-jerry.huang@nxp.com>
 <1482139554-13618-2-git-send-email-jerry.huang@nxp.com>
Message-ID: <20161222184514.hfd4g7ifrz5cv627@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 05:25:53PM +0800, Changming Huang wrote:
> New property "snps,incr-burst-type-adjustment = <x>, <y>" for USB3.0 DWC3.
> Field "x": 1/0 - undefined length INCR burst type enable or not;
> Field "y": INCR4/INCR8/INCR16/INCR32/INCR64/INCR128/INCR256 burst type.
> 
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platform:
> around 3% improvement (from 364MB/s to 375MB/s).
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> Changes in v3:
>   - add new property for INCR burst in usb node.
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    5 +++++
>  arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |    2 ++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index e3e6983..8c405a3 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -55,6 +55,10 @@ Optional properties:
>  	fladj_30mhz_sdbnd signal is invalid or incorrect.
>  
>   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> + - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
> +	register, undefined length INCR burst type enable and INCRx type.
> +	First field is for undefined length INCR burst type enable or not.
> +	Second field is for largest INCRx type enabled.

Why do you need the first field? Is the 2nd field used if the 1st is 0? 
If not, then just use the presence of the property to enable or not.

Rob
