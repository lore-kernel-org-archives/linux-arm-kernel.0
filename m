From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 08 Aug 2013 23:39:47 +0400
Subject: [PATCH 3/3] crypto: dcp: rename 'compatible' property to 'fsl,
 dcp'
In-Reply-To: <1375968629-10091-4-git-send-email-LW@KARO-electronics.de>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
 <1375968629-10091-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <5203F403.1040800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/08/2013 05:30 PM, Lothar Wa?mann wrote:

> Leave the old 'fsl-dcp' value in place with an appropriate comment
> until external users have updated their DTBs.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>   arch/arm/boot/dts/imx28.dtsi |    2 +-
>   drivers/crypto/dcp.c         |    2 ++
>   2 files changed, 3 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index ea99d09..0584935 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -794,7 +794,7 @@
>   			};
>
>   			dcp: dcp at 80028000 {

     By the way, I see that this is a crypto device, so it should be named 
"crypto" according to ePAPR spec. [1]

> -				compatible = "fsl-dcp";
> +				compatible = "fsl,dcp";
>   				reg = <0x80028000 0x2000>;
>   				interrupts = <52 53 54>;
>   				status = "disabled";

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
