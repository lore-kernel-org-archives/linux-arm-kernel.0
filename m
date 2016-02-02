From: robh@kernel.org (Rob Herring)
Date: Tue, 2 Feb 2016 15:24:54 -0600
Subject: [PATCH 06/10] devicetree: bindings: add DT binding for the
 Marvell Armada 3700 SoC family
In-Reply-To: <1454436468-4241-7-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160202212454.GA21678@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:07:44PM +0100, Gregory CLEMENT wrote:
> The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
> introduces the Device Tree binding that documents the top-level
> compatible strings for Armada 3700 based platforms.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> new file mode 100644
> index 000000000000..5db9f1a90da2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> @@ -0,0 +1,17 @@
> +Marvell Armada 37xx Platforms Device Tree Bindings
> +--------------------------------------------------
> +
> +Boards using a SoC of the Marvell Armada 37xx family must carry the
> +following root node property:
> +
> + - compatible: must contain "marvell,armada3700"

Is 3700 an actual chip? If not, please drop this. 

> +
> +In addition, depending on whether the Armada 3710 or Armada 3720 SoCs
> +are being used, the following root node property must be added:
> +
> + - compatible: must contain either "marvell,armada3710" or
> +   "marvell,armada3720"
> +
> +Example:
> +
> +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
