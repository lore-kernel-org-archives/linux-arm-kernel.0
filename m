From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 May 2015 15:18:52 +0200
Subject: [PATCH] ARM: mvebu: armada-xp-linksys-mamba: Disable internal RTC
In-Reply-To: <1432156924-1030-1-git-send-email-kaloz@openwrt.org>
References: <1432156924-1030-1-git-send-email-kaloz@openwrt.org>
Message-ID: <5563213C.8090305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Imre,

On 20/05/2015 23:22, Imre Kaloz wrote:
> The Mamba (like the OpenBlocks AX3) doesn't have a crystal
> connected to the internal RTC - let's prevent the kernel from
> probing it.
> 

applied on mvebu/fixes

Thanks,

Gregory


> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> Cc: <stable@vger.kernel.org> # v4.0 +
> ---
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> index a2cf215..fdd187c 100644
> --- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> +++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> @@ -95,6 +95,11 @@
>  
>  		internal-regs {
>  
> +			rtc at 10300 {
> +				/* No crystal connected to the internal RTC */
> +				status = "disabled";
> +			};
> +
>  			/* J10: VCC, NC, RX, NC, TX, GND  */
>  			serial at 12000 {
>  				status = "okay";
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
