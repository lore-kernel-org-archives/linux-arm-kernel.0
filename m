From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 30 Jun 2017 20:05:36 -0700
Subject: [Patch v2 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
In-Reply-To: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Message-ID: <20170701030534.GB11424@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 11:42:01AM +0800, Tao Wang wrote:
> This adds documentation of device tree bindings for the
> thermal sensor controller of hi3660 SoC.
> 
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> ---
> Changes in v2:
> - remove redundant property
> 
>  .../devicetree/bindings/thermal/hi3660-thermal.txt |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
> new file mode 100644
> index 0000000..f3dddcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
> @@ -0,0 +1,16 @@
> +* Temperature Sensor on hisilicon hi3660 SoC
> +

Would you mind add some more description of the sensors/where to find
further hardware documentation?

> +** Required properties :
> +
> +- compatible: "hisilicon,thermal-hi3660".
> +- reg: physical base address of thermal sensor and length of memory mapped
> +  region.
> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
> +
> +Example :
> +
> +	tsensor: tsensor {
> +		compatible = "hisilicon,thermal-hi3660";
> +		reg = <0x0 0xfff30000 0x0 0x1000>;
> +		#thermal-sensor-cells = <1>;
> +	 };
> -- 
> 1.7.9.5
> 
