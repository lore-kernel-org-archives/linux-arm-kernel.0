From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 08 Jul 2016 10:23:28 -0700
Subject: [PATCH 2/2] arm64: dts: set UART1 clock frequency to 150MHz
In-Reply-To: <1467965467-28180-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1467965467-28180-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <146799860795.73491.14234650786991740924@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2016-07-08 01:11:07)
> Enable support for higher baud rates (up to 3Mbps) in UART1 - required
> for bluetooth transfers.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Reviewed-by: Michael Turquette <mturquette@baylibre.com>

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index e92a30c..27be812 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -55,6 +55,8 @@
>                 };
>  
>                 uart1: uart at f7111000 {
> +                       assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
> +                       assigned-clock-rates = <150000000>;
>                         status = "ok";
>                 };
>  
> -- 
> 2.7.4
> 
