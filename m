From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 8 Jan 2013 21:01:49 +0100
Subject: [v3 PATCH 9/9] ARM: dts: add the watchdog nodes for
 at91sam9g25ek boards
In-Reply-To: <1357353529-20901-10-git-send-email-wenyou.yang@atmel.com>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
 <1357353529-20901-10-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130108200149.GE7360@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:38 Sat 05 Jan     , Wenyou Yang wrote:
> Tested on the at91sam9g25ek boards
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: linux at arm.linux.org.uk
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/at91sam9x5ek.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> index 8a7cf1d..afddf75 100644
> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -69,6 +69,10 @@
>  				status = "okay";
>  			};
>  
> +			watchdog at fffffe40 {
> +				status = "okay";
> +			};
> +

use less today as the watchdog is shutdown at bootstrap level

and on at91 once shutdown we can not enable it again

Best Regards,
J.
>  			pinctrl at fffff400 {
>  				mmc0 {
>  					pinctrl_board_mmc0: mmc0-board {
> -- 
> 1.7.9.5
> 
