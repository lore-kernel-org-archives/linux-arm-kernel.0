From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Mar 2013 16:39:34 +0200
Subject: [PATCH v2 8/8] ARM: dts: omap5: add dwc3 core dt data
In-Reply-To: <1362494223-14151-9-git-send-email-kishon@ti.com>
References: <1362494223-14151-1-git-send-email-kishon@ti.com>
 <1362494223-14151-9-git-send-email-kishon@ti.com>
Message-ID: <20130305143934.GB12123@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 05, 2013 at 08:07:03PM +0530, Kishon Vijay Abraham I wrote:
> Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
> data file. The information for the entered data node is available @
> Documentation/devicetree/bindings/usb/dwc3.txt
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index c4eb2ec..24dd69f 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -514,6 +514,13 @@
>  			#size-cells = <1>;
>  			utmi-mode = <2>;
>  			ranges;
> +			dwc3 at 4a030000 {
> +				compatible = "synopsys,dwc3";
> +				reg = <0x4a030000 0x1000>;
> +				interrupts = <0 92 4>;
> +				usb-phy = <&usb2_phy>, <&usb3_phy>;
> +				tx-fifo-resize;

I think this should be merged with previous patch. Also, we need to
check whether tx-fifo-resize is needed with ES2 or not ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130305/fff1b547/attachment.sig>
