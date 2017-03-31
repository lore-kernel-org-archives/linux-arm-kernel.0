From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 30 Mar 2017 20:17:23 -0700
Subject: [PATCH V2 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
In-Reply-To: <20170323223045.15786-1-zajec5@gmail.com>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170323223045.15786-1-zajec5@gmail.com>
Message-ID: <20170331031721.GB3161@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rafal,

On Thu, Mar 23, 2017 at 11:30:44PM +0100, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> This commit documents binding for thermal used in Northstar family SoCs.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/thermal/brcm,ns-thermal         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> new file mode 100644
> index 000000000000..9a22dd76ec01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
> @@ -0,0 +1,17 @@
> +* Broadcom Northstar Thermal
> +
> +This binding describes thermal sensor that is part of Northstar's DMU (Device
> +Management Unit).
> +
> +Required properties:
> +- compatible : Must be "brcm,ns-thermal"
> +- reg : iomem address range of PVTMON registers
> +- #thermal-sensor-cells : Should be <0>
> +
> +Example:
> +
> +thermal {
> +	compatible = "brcm,ns-thermal";
> +	reg = <0x1800c2c0 0x10>;
> +	#thermal-sensor-cells = <0>;
> +};


Could you please also include an example of the thermal zone one should
include in the board/cpu DTS while using this sensor? 

Besides, based on what I saw you in your driver, you could also describe
your offset and slope in DT, and read them using thermal helpers.

BR,
> -- 
> 2.11.0
> 
