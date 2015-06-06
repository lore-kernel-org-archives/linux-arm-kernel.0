From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 07 Jun 2015 01:07:01 +0300
Subject: [PATCH 4/6] ARM: dts;
 pxa: add embedded pxa camera capture interface
In-Reply-To: <1433624953-28165-4-git-send-email-robert.jarzmik@free.fr>
References: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
 <1433624953-28165-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <55736F05.8000904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/07/2015 12:09 AM, Robert Jarzmik wrote:

> The pxa27x SoCs have an embedded camera host controller. Add the
> description to the family description.

> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>   arch/arm/boot/dts/pxa27x.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> index 506db86..9ebfd7f 100644
> --- a/arch/arm/boot/dts/pxa27x.dtsi
> +++ b/arch/arm/boot/dts/pxa27x.dtsi
> @@ -77,6 +77,23 @@
>   			clocks = <&clks CLK_KEYPAD>;
>   			status = "disabled";
>   		};
> +
> +		pxa_camera: pxa_camera at 50000000 {

    The ePAPR standard has something to say about the node naming:
"The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model." So I'd suggest "video at 50000000" 
instead...

[...]

WBR, Sergei
