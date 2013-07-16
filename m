From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Jul 2013 09:24:30 -0400
Subject: [PATCH 06/10] watchdog: orion: Update device-tree binding
 documentation
In-Reply-To: <1373931163-12670-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373931163-12670-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130716132430.GD12062@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 08:32:39PM -0300, Ezequiel Garcia wrote:
> Now that the 'reg' property meaning has been changed,
> this commit updates the deivce-tree binding documentation.

nit. s/deivce/device/

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> index 5dc8d30..48a71fc 100644
> --- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> @@ -3,7 +3,8 @@
>  Required Properties:
>  
>  - Compatibility : "marvell,orion-wdt"
> -- reg		: Address of the timer registers
> +- reg		: First cell contains the register for the watchdog counter.
> +		  Second cell contains the register for the RSTOUT mask.
>  
>  Optional properties:
>  
> @@ -11,9 +12,10 @@ Optional properties:
>  
>  Example:
>  
> -	wdt at 20300 {
> +	wdt at 20324 {
>  		compatible = "marvell,orion-wdt";
> -		reg = <0x20300 0x28>;
> +		reg = <0x20324 0x4
> +		       0x20108 0x4>;
>  		timeout-sec = <10>;
>  		status = "okay";
>  	};
> -- 
> 1.8.1.5
> 
