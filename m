From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jan 2014 11:39:20 +0000
Subject: [PATCH V4 5/5] Documentation: power: reset: Add documentation
 for generic SYSCON reboot driver
In-Reply-To: <1390504801-24483-6-git-send-email-fkan@apm.com>
References: <1390504801-24483-1-git-send-email-fkan@apm.com>
 <1390504801-24483-6-git-send-email-fkan@apm.com>
Message-ID: <20140124113920.GF814@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 07:20:01PM +0000, Feng Kan wrote:
> Add documentation for generic SYSCON reboot driver.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  .../bindings/power/reset/syscon-reboot.txt         |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> new file mode 100644
> index 0000000..e9eb1fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> @@ -0,0 +1,16 @@
> +Generic SYSCON mapped register reset driver

Bindings should describe hardware, not drivers.

What precisely does this binding describe?

> +
> +Required properties:
> +- compatible: should contain "syscon-reboot"
> +- regmap: this is phandle to the register map node 
> +- offset: offset in the register map for the reboot register
> +- mask: the reset value written to the reboot register
> +
> +Examples:
> +
> +reboot {
> +   compatible = "syscon-reboot";
> +   regmap = <&regmapnode>;
> +   offset = <0x0>;
> +   mask = <0x1>;
> +};

Access size? Endianness?

Why can we not have a binding for the register bank this exists in, and
have that pass on the appropriate details to a syscon-reboot driver?

That way we can change the way we poke things without requiring changes
to bindings or dts.

Thanks,
Mark.
