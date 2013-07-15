From: r65037@freescale.com (Zhu Richard-R65037)
Date: Mon, 15 Jul 2013 02:13:17 +0000
Subject: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
In-Reply-To: <51E069D0.7030204@cogentembedded.com>
References: <1373622078-18723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <51E069D0.7030204@cogentembedded.com>
Message-ID: <0E83723C55F66F43A6041464FE31119D33BCFF@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei:
Thanks for your comments.


Best Regards
Richard Zhu


-----Original Message-----
From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com] 
Sent: Saturday, July 13, 2013 4:41 AM
To: Richard Zhu
Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; tj at kernel.org; rob.herring at calxeda.com; s.hauer at pengutronix.de; linux-ide at vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms

On 07/12/2013 01:41 PM, Richard Zhu wrote:

> From: Richard Zhu <r65037@freescale.com>

> Only imx6q has the ahci sata controller, enable it on imx6q platforms.

> Signed-off-by: Richard Zhu <r65037@freescale.com>
[...]

> diff --git a/arch/arm/boot/dts/imx6q.dtsi 
> b/arch/arm/boot/dts/imx6q.dtsi index e7dd2c4..93b65d9 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -424,6 +424,15 @@
>   			};
>   		};
>
> +		ahci: ahci at 02200000 {

    According to ePAPR [1] section 2.2.2, "the name of the node should be somewhat generic, reflecting the function of the device and not its precise programming model. If appropriate, the name should be one of the following choices:
[...]
- sata;
[...]"

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
[Richard] Ok, ahci would be replaced by sata.

WBR, Sergei
