From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Nov 2015 16:59:04 -0600
Subject: [PATCH v3 2/5] dt-bindings: soc: add document for rockchip
 reboot notifier driver
In-Reply-To: <1447840410-19794-1-git-send-email-andy.yan@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <1447840410-19794-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20151118225904.GA5429@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 05:53:30PM +0800, Andy Yan wrote:
> Add devicetree binding document for rockchip reboot nofifier driver

Just reading the subject this is way too specific to the Linux driver 
needs rather than a h/w description. Please don't create fake DT nodes 
just to bind to drivers. Whatever &pmu is is probably what should have 
the DT node. Let the driver for it create child devices if you need 
that.

Rob
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v3:
>  - add dt binding
> 
> Changes in v2: None
> 
>  .../bindings/soc/rockchip/rockchip-reboot.txt          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt b/Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt
> new file mode 100644
> index 0000000..6f69c8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt
> @@ -0,0 +1,18 @@
> +Rockchip reboot notifier driver
> +
> +This driver get reboot mode arguments from userspace
> +and stores it in special register. Then the bootloader
> +will read it and take different action according the
> +argument stored.
> +
> +Required properties:
> +- compatible: should be "rockchip,reboot"
> +- regmap: this is phandle to the register map node
> +- offset: offset in the register map for the storage register (in bytes)
> +
> +Examples:
> +	reboot {
> +	   compatible = "rockchip,reboot";
> +	   regmap = <&pmu>;
> +	   offset = <0x94>;
> +	};
> -- 
> 1.9.1
> 
> 
