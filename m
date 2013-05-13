From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 10:47:13 -0600
Subject: [PATCH 1/6] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <1368443225-16978-2-git-send-email-hdoyu@nvidia.com>
References: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
 <1368443225-16978-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <51911911.2000107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 05:07 AM, Hiroshi Doyu wrote:
> To replace magic number in tegra_car:
> 
> -               clocks = <&tegra_car 28>;
> +               clocks = <&tegra_car CLK_HOST1X>;

> @@ -172,7 +26,7 @@ Example SoC include file:
>  	};
>  
>  	usb at c5004000 {
> -		clocks = <&tegra_car 58>; /* usb2 */
> +		clocks = <&tegra_car TEGRA20_CLK_USB2>; /* usb2 */

I forgot to mention: That comment isn't useful any more, since it's
obvious this represents the USB2 clock now that the actual cell data
uses a define.
