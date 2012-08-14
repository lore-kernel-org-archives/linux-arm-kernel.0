From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 14 Aug 2012 06:55:54 +0000
Subject: [PATCH] arm/dts: AM33XX: Set the default status of module to
 "disabled" state
In-Reply-To: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
References: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA121C9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

On Mon, Aug 06, 2012 at 16:59:04, Hiremath, Vaibhav wrote:
> Ideally in common SoC dtsi file we should set all modules
> to "disabled" state and it should get enabled in respective
> EVM/Board dts file as per usage.
> 
> This patch sets default status of all modules to "disabled"
> state in am33xx.dtsi file, and as per board requirement, enabled
> in board dts file (like, bone, evm, etc...).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> CC: Tony Lindgren <tony@atomide.com>
> ---
> This patch is tested on BeagleBone platform.
> 
>  arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
>  arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
>  arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
>  3 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index a9af4db..df672b4 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -17,4 +17,10 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
> +
> +	ocp {
> +		uart1: serial at 44E09000 {
> +			       status = "okay";
> +		       };

Minor change, correct indentation here.

> +	};
>  };
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index d6a97d9..00bbae8 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -17,4 +17,10 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
> +
> +	ocp {
> +		uart1: serial at 44E09000 {
> +			       status = "okay";
> +		       };

ditto

Regards
AnilKumar
