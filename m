From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 01 Feb 2015 14:26:50 +0300
Subject: [PATCH 5/5] ARM: dts: pxa: add pxa-timer to pxa27x
In-Reply-To: <1422744510-3179-5-git-send-email-robert.jarzmik@free.fr>
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
 <1422744510-3179-5-git-send-email-robert.jarzmik@free.fr>
Message-ID: <54CE0D7A.3070603@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/1/2015 1:48 AM, Robert Jarzmik wrote:

> Each pxa has an embedded OS Timers IP. The kernel cannot work without a
> valid clocksource, and this adds the OS Timers to the pxa device-tree
> description.

> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>   arch/arm/boot/dts/pxa27x.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> index 7f93828..9e6bf60 100644
> --- a/arch/arm/boot/dts/pxa27x.dtsi
> +++ b/arch/arm/boot/dts/pxa27x.dtsi
> @@ -97,5 +97,18 @@
>   			status = "okay";
>   		};
>   	};
> +
> +	clocksources {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pxa-timer at 40a00000 {

    Just "timer at 40a00000", please.

WBR, Sergei
