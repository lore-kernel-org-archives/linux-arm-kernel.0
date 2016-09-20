From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Sep 2016 17:07:06 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: fix clocksource for CP110 slave
 SPI0
In-Reply-To: <1473183672-12028-3-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Tue, 6 Sep 2016 19:41:12 +0200")
References: <1473183672-12028-1-git-send-email-mw@semihalf.com>
 <1473183672-12028-3-git-send-email-mw@semihalf.com>
Message-ID: <87pony625h.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,
 
 On mar., sept. 06 2016, Marcin Wojtas <mw@semihalf.com> wrote:

> I2C and SPI interfaces share common clock trees within the CP110 HW block.
> It occurred that SPI0 interface has wrong clock assignment in the device
> tree, which is fixed in this commit to a proper value.
>
> Fixes: c749b8d9de32 ("arm64: dts: marvell: add description for the ...")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Could you take this patch for 4.9? I didn't realized at first view it
was for 4.9, I though I could put it the PR for fixes for 4.8.

I can do a new PR for dt64 with this single patch if you prefer.

The last option will be to have it as a fix for v4.9-rc2.

Thanks,

Gregory



> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 37bff70..150675c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -133,7 +133,7 @@
>  				#address-cells = <0x1>;
>  				#size-cells = <0x0>;
>  				cell-index = <1>;
> -				clocks = <&cps_syscon0 0 3>;
> +				clocks = <&cps_syscon0 1 21>;
>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
