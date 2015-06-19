From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jun 2015 21:44:31 +0300
Subject: [PATCH v2 6/6] ARM: dts: pxa: add the usb host controller
In-Reply-To: <1434739102-26217-6-git-send-email-robert.jarzmik@free.fr>
References: <1434739102-26217-1-git-send-email-robert.jarzmik@free.fr>
 <1434739102-26217-6-git-send-email-robert.jarzmik@free.fr>
Message-ID: <5584630F.2070402@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/19/2015 09:38 PM, Robert Jarzmik wrote:

> Add the usb host controller to pxa27x and pxa3xx.

> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>   arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
>   arch/arm/boot/dts/pxa3xx.dtsi | 8 ++++++++
>   2 files changed, 16 insertions(+)

> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> index fc79df9..97220ac 100644
> --- a/arch/arm/boot/dts/pxa27x.dtsi
> +++ b/arch/arm/boot/dts/pxa27x.dtsi
> @@ -26,6 +26,14 @@
>   			clocks = <&clks CLK_NONE>;
>   		};
>
> +		pxa27x_ohci: ohci at 4c000000 {

    Sigh. ePAPR standardizes the "usb" name for such nodes.
[...]
> diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
> index 29aeac5..67bd4fe 100644
> --- a/arch/arm/boot/dts/pxa3xx.dtsi
> +++ b/arch/arm/boot/dts/pxa3xx.dtsi
> @@ -86,6 +86,14 @@
>   			dma-names = "rx", "tx";
>   			status = "disabled";
>   		};
> +
> +		pxa3xx_ohci: ohci at 4c000000 {

    Ditto.

[...]

WBR, Sergei
