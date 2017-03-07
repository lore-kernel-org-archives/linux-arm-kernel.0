From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Mar 2017 17:27:36 +0100
Subject: [PATCH] ARM: dts: armada-38x: Adjust mbus controller description
 on Armada 38x
In-Reply-To: <20170216163826.28071-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 16 Feb 2017 17:38:26 +0100")
References: <20170216163826.28071-1-gregory.clement@free-electrons.com>
Message-ID: <87k281oxvr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On jeu., f?vr. 16 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The mbus binding had been extended more than two years ago, but the
> device tree files for Armada 38x didn't change.
>
> Adding this third entry will allow the mbus going to suspend which was
> the last thing preventing the SoC going to standby mode
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Now applied on mvebu/dt

Gregory

> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index c558a5d6a21f..ba27ec104981 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -360,7 +360,8 @@
>  
>  			mbusc: mbus-controller at 20000 {
>  				compatible = "marvell,mbus-controller";
> -				reg = <0x20000 0x100>, <0x20180 0x20>;
> +				reg = <0x20000 0x100>, <0x20180 0x20>,
> +				      <0x20250 0x8>;
>  			};
>  
>  			mpic: interrupt-controller at 20a00 {
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
