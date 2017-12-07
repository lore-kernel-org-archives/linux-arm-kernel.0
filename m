From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Dec 2017 17:20:33 -0600
Subject: [PATCH v3 06/12] dt-bindings: Document the Rockchip ISP1 bindings
In-Reply-To: <20171206111939.1153-7-jacob-chen@iotwrt.com>
References: <20171206111939.1153-1-jacob-chen@iotwrt.com>
 <20171206111939.1153-7-jacob-chen@iotwrt.com>
Message-ID: <20171207232033.itx4pvdgkyl4a5qp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 07:19:33PM +0800, Jacob Chen wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> Add DT bindings documentation for Rockchip ISP1
> 
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  .../devicetree/bindings/media/rockchip-isp1.txt    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-isp1.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.txt b/Documentation/devicetree/bindings/media/rockchip-isp1.txt
> new file mode 100644
> index 000000000000..0971ed94ed69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip-isp1.txt
> @@ -0,0 +1,57 @@
> +Rockchip SoC Image Signal Processing unit v1
> +----------------------------------------------
> +
> +Rockchip ISP1 is the Camera interface for the Rockchip series of SoCs
> +which contains image processing, scaling, and compression funcitons.
> +
> +Required properties:
> +  - compatible: value should be one of the following
> +      "rockchip,rk3288-cif-isp";
> +      "rockchip,rk3399-cif-isp";
> +  - reg : offset and length of the register set for the device.
> +  - interrupts: should contain ISP interrupt.
> +  - clocks: phandle to the required clocks.
> +  - clock-names: required clock name.
> +  - iommus: required a iommu node.
> +
> +The device node should contain one 'port' child node with child 'endpoint'
> +nodes, according to the bindings defined in Documentation/devicetree/bindings/
> +media/video-interfaces.txt.
> +
> +For sensor with a parallel video bus, it could be linked directly to the isp.
> +For sensor with a MIPI CSI-2 video bus, it should be linked through the
> +MIPI-DPHY, which is defined in rockchip-mipi-dphy.txt.

As I mentioned on the last version, you need to list that there are 2 
endpoints for the port and what their assignment is.

Rob
