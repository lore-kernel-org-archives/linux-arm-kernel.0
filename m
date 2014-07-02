From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Jul 2014 11:06:47 +0200
Subject: [PATCH/RFC 6/6] ARM: shmobile: bockw: Initialise TMU device using
 DT
In-Reply-To: <1404275322-26514-7-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
 <1404275322-26514-7-git-send-email-horms+renesas@verge.net.au>
Message-ID: <2964831.rTbpWqUrsN@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 02 July 2014 06:28:42 Simon Horman wrote:
> Initialise TMU device using DT when booting bockw
> using DT-reference.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> N.B: This only enables the production serial port (scif0) and not the
> debug serial port. It is unclear to me if the debug port is scif1 or scif5.
> And if the required PFC support is in place. At the very least the
> latter appears to be missing from r8a7778-bockw-reference.dts.

I don't think this comment applies.

> ---
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts | 4 ++++
>  arch/arm/mach-shmobile/setup-r8a7778.c        | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> b/arch/arm/boot/dts/r8a7778-bockw-reference.dts index 5d14688..b70ef30
> 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> @@ -73,6 +73,10 @@
>  	status = "okay";
>  };
> 
> +&tmu0 {
> +	status = "okay";
> +};
> +
>  &pfc {
>  	scif0_pins: serial0 {
>  		renesas,groups = "scif0_data_a", "scif0_ctrl";
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c
> b/arch/arm/mach-shmobile/setup-r8a7778.c index e218c46..575148d 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -293,8 +293,6 @@ void __init r8a7778_add_dt_devices(void)
>  		l2x0_init(base, 0x00400000, 0xc20f0fff);
>  	}
>  #endif
> -
> -	r8a7778_register_tmu(0);
>  }
> 
>  /* HPB-DMA */
> @@ -502,6 +500,7 @@ static void __init r8a7778_register_hpb_dmae(void)
>  void __init r8a7778_add_standard_devices(void)
>  {
>  	r8a7778_add_dt_devices();
> +	r8a7778_register_tmu(0);
>  	r8a7778_register_scif(0);
>  	r8a7778_register_scif(1);
>  	r8a7778_register_scif(2);

-- 
Regards,

Laurent Pinchart
