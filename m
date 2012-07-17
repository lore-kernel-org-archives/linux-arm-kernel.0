From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 17 Jul 2012 16:36:08 +0400
Subject: [PATCH 2/2] arm/dts: omap4: Add ocp2scp data
In-Reply-To: <1342448023-14438-3-git-send-email-kishon@ti.com>
References: <1342448023-14438-1-git-send-email-kishon@ti.com>
 <1342448023-14438-3-git-send-email-kishon@ti.com>
Message-ID: <50055C38.3000309@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-07-2012 18:13, Kishon Vijay Abraham I wrote:

> Add ocp2scp data node in omap4 device tree file.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 359c497..bda5df3 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -272,5 +272,13 @@
>   			ti,hwmods = "mmc5";
>   			ti,needs-special-reset;
>   		};
> +
> +		ocp2scp at 4a0ad000  {

    "reg" property is absent, so why do you give the node name an address postfix?

> +			compatible = "ti,omap-ocp2scp";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			ti,hwmods = "ocp2scp_usb_phy";
> +		};

WBR, Sergei
