From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 23 Apr 2013 14:43:48 +1200
Subject: [RFC PATCH v2 12/13] ARM: mach-vt8500: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-13-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-13-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5175F564.8030405@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/13 03:27, Lorenzo Pieralisi wrote:
> This patch updates the in-kernel dts files according to the latest cpus
> and cpu bindings updates for ARM.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   arch/arm/boot/dts/wm8505.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
> index e74a1c0..a470808 100644
> --- a/arch/arm/boot/dts/wm8505.dtsi
> +++ b/arch/arm/boot/dts/wm8505.dtsi
> @@ -13,7 +13,7 @@
>   
>   	cpus {
>   		cpu at 0 {
> -			compatible = "arm,arm926ejs";
> +			compatible = "arm,arm926";
>   		};
>   	};
>   
The more I look at this, the more wrong it is :/

 From the new binding documentation,

+	A cpus node must define the following properties:
+
+	- #address-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be set to 1 for 32-bit systems and 2 for
+			    64-bit systems
+	- #size-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be set to 0

...

+- cpu node
+
+	Description: Describes a CPU in an ARM based system
+
+	PROPERTIES
+
+	- device_type
+		Usage: required
+		Value type: <string>
+		Definition: must be "cpu"

Three required properties that aren't present in the patch.

cpus {
     #size-cells = <0>;
     #address-cells = <1>;

     cpu {
         device_type = "cpu"
         compatible = "arm,arm926";
     };
};

Regards
Tony P
