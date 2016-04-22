From: robh@kernel.org (Rob Herring)
Date: Fri, 22 Apr 2016 15:13:51 -0500
Subject: [PATCH 5/6] Documentation: Binding doc for ethernet master in NS2
In-Reply-To: <1461230323-27891-6-git-send-email-pramod.kumar@broadcom.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-6-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160422201351.GA3048@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 02:48:42PM +0530, Pramod Kumar wrote:
> Adding binding doc for ethernet master present in shared
> MDIO controller.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/net/brcm,iproc-mdio-shared.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,iproc-mdio-shared.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,iproc-mdio-shared.txt b/Documentation/devicetree/bindings/net/brcm,iproc-mdio-shared.txt
> new file mode 100644
> index 0000000..1ffdd4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/brcm,iproc-mdio-shared.txt
> @@ -0,0 +1,32 @@
> +Broadcom Ethernet master for shared mdio controller
> +
> +Required properties:
> +- compatible: must be "brcm,iproc-mdio-master-eth"
> +- reg: master id of Ethernet block
> +- address-cells: should be 1
> +- size-cells: should be 0
> +
> +Sub-nodes:
> +  Each port's PHY should be represented as a sub-node.
> +
> +Sub-nodes required properties:
> +- reg: the PHY number
> +- phy-mode: media type connecting the PHY and MAC.
> +
> +
> +Example:
> +	eth-master at 0 {

Is this a child of something?

Why is this not just an mdio bus underneath the ethernet controller? How 
is this accessed?

> +		compatible = "brcm,iproc-mdio-master-eth";
> +		reg = <0x0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gphy0: eth-phy at 10 {
> +			reg = <0x10>;
> +			phy-mode = "mii";
> +		};
> +		status = "ok"
> +	};
> +
> +For more info on ethernet phy binding, please,refer to:
> +Documentation/devicetree/bindings/net/phy.txt
> +Documentation/devicetree/bindings/net/ethernet.txt
> -- 
> 1.9.1
> 
