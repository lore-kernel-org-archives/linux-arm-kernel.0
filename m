From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:28:16 +0200
Subject: [PATCH v2 30/38] ARM: orion5x: use DT to describe EHCI on
 edmini_v2
In-Reply-To: <1398202002-28530-31-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-31-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A3D0.6030503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for USB.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 4 ++++
>   arch/arm/mach-orion5x/edmini_v2-setup.c                   | 2 --
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index 41b2ab5..f0f2bcc 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -56,6 +56,10 @@
>   	};
>   };
>
> +&ehci0 {
> +	status = "okay";
> +};
> +
>   &eth {
>   	status = "okay";
>
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> index 75648ab..2eebc0c 100644
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
> @@ -104,8 +104,6 @@ void __init edmini_v2_init(void)
>   	/*
>   	 * Configure peripherals.
>   	 */
> -	orion5x_ehci0_init();
> -
>   	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
>   				    ORION_MBUS_DEVBUS_BOOT_ATTR,
>   				    EDMINI_V2_NOR_BOOT_BASE,
>
