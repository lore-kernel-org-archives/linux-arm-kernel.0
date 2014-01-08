From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jan 2014 10:05:50 +0000
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene
 reboot dts node.
In-Reply-To: <1389135041-16062-2-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <1389135041-16062-2-git-send-email-fkan@apm.com>
Message-ID: <20140108100549.GE6701@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 10:50:36PM +0000, Feng Kan wrote:
> Add X-Gene reboot device tree node documentation.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  .../devicetree/bindings/arm64/xgene/reboot.txt     |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm64/xgene/reboot.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm64/xgene/reboot.txt b/Documentation/devicetree/bindings/arm64/xgene/reboot.txt
> new file mode 100644
> index 0000000..51d23c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm64/xgene/reboot.txt
> @@ -0,0 +1,10 @@
> +Reboot property to control system reboot on storm platforms:
> +
> +The register attribute contain the address of the reset register.

Required properties:

- compatible: should contain "apm,xgene-reboot"

- reg: the base address and size of the reset register.

> +
> +Example:
> +
> +	reboot at 0 {
> +		compatible = "apm,xgene-reboot";
> +		reg = <0x0 0x17000014 0x0 0x4>;
> +	};

Given this seems to be a 64-bit address, the unit address should
preferably be 0,17000014 rather than just 0.

Thanks,
Mark.
