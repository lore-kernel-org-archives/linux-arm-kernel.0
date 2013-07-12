From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 13 Jul 2013 00:40:48 +0400
Subject: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
In-Reply-To: <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1373622078-18723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <51E069D0.7030204@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2013 01:41 PM, Richard Zhu wrote:

> From: Richard Zhu <r65037@freescale.com>

> Only imx6q has the ahci sata controller, enable
> it on imx6q platforms.

> Signed-off-by: Richard Zhu <r65037@freescale.com>
[...]

> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7dd2c4..93b65d9 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -424,6 +424,15 @@
>   			};
>   		};
>
> +		ahci: ahci at 02200000 {

    According to ePAPR [1] section 2.2.2, "the name of the node should 
be somewhat generic, reflecting the function of the device and not its
precise programming model. If appropriate, the name should be one of the 
following choices:
[...]
- sata;
[...]"

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
