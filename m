From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Sep 2015 15:43:14 +0200
Subject: [PATCH 2/2] ARM: mvebu: add CPU config registers in the Armada
 370/XP Device Tree
In-Reply-To: <1436364561-20958-3-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 8 Jul 2015 16:09:21 +0200")
References: <1436364561-20958-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436364561-20958-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87612ts5n1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., juil. 08 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit adds the description of the CPU config registers in the
> Armada 370 and Armada XP Device Tree. Since the registers are in fact
> different between the two SoCs, a different compatible string is used.
>
> Note that the Armada 370 node is currently unused, but it is
> nonetheless added for consistency with the addition on the Armada XP
> side.

Applied on mvebu/dt

Thanks,

Gregory

>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 5 +++++
>  arch/arm/boot/dts/armada-xp.dtsi  | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 53a1a5a..45eff24 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -256,6 +256,11 @@
>  				reg = <0x20800 0x8>;
>  			};
>  
> +			cpu-config at 21000 {
> +				compatible = "marvell,armada-370-cpu-config";
> +				reg = <0x21000 0x8>;
> +			};
> +
>  			audio_controller: audio-controller at 30000 {
>  				#sound-dai-cells = <1>;
>  				compatible = "marvell,armada370-audio";
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 3de9b76..1c64ac3 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -184,6 +184,11 @@
>  				reg = <0x20800 0x20>;
>  			};
>  
> +			cpu-config at 21000 {
> +				compatible = "marvell,armada-xp-cpu-config";
> +				reg = <0x21000 0x8>;
> +			};
> +
>  			eth2: ethernet at 30000 {
>  				compatible = "marvell,armada-xp-neta";
>  				reg = <0x30000 0x4000>;

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
