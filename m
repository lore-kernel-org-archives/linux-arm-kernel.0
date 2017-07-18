From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 15:34:13 +0200
Subject: [PATCH 1/3] arm64: dts: marvell: use ICU for the CP110 slave RTC
In-Reply-To: <20170718131034.25167-2-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 18 Jul 2017 15:10:32 +0200")
References: <20170718131034.25167-1-thomas.petazzoni@free-electrons.com>
 <20170718131034.25167-2-thomas.petazzoni@free-electrons.com>
Message-ID: <87pocx7tt6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., juil. 18 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> When the conversion of the Marvell CP110 Device Tree description from
> using GIC interrupts to using ICU interrupts was done, the RTC on the
> slave CP110 was left unchanged. This commit fixes that, so that all
> devices on the CP properly get their interrupt through the ICU.
>
> Fixes: 6ef84a827c375 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
> There's no need for a Cc: stable, because the ICU conversion was
> merged in 4.13-rc1.
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 8c08a64..67936f7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -64,7 +64,7 @@
>  				compatible = "marvell,armada-8k-rtc";
>  				reg = <0x284000 0x20>, <0x284080 0x24>;
>  				reg-names = "rtc", "rtc-soc";
> -				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
>  			cps_ethernet: ethernet at 0 {
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
