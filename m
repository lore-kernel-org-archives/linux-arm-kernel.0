From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Sep 2016 16:56:55 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: fix clocksource for CP110 master
 SPI0
In-Reply-To: <1473183672-12028-2-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Tue, 6 Sep 2016 19:41:11 +0200")
References: <1473183672-12028-1-git-send-email-mw@semihalf.com>
 <1473183672-12028-2-git-send-email-mw@semihalf.com>
Message-ID: <87twda62mg.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On mar., sept. 06 2016, Marcin Wojtas <mw@semihalf.com> wrote:

> I2C and SPI interfaces share common clock trees within the CP110 HW block.
> It occurred that SPI0 interface has wrong clock assignment in the device
> tree, which is fixed in this commit to a proper value.
>
> Fixes: 728dacc7f4dd ("arm64: dts: marvell: initial DT description of ...")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> CC: <stable@vger.kernel.org> v4.7+

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index db1be4c..903b0f6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -133,7 +133,7 @@
>  				#address-cells = <0x1>;
>  				#size-cells = <0x0>;
>  				cell-index = <1>;
> -				clocks = <&cpm_syscon0 0 3>;
> +				clocks = <&cpm_syscon0 1 21>;
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
