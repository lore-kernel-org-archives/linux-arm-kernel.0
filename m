From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 15:47:35 +0900
Subject: [PATCH v2 07/09] ARM: s3c2440: gta02: Call
	regulator_has_full_constraints
In-Reply-To: <1297133720-18178-1-git-send-email-lars@metafoo.de>
References: <1297043521-21903-7-git-send-email-lars@metafoo.de>
	<1297133720-18178-1-git-send-email-lars@metafoo.de>
Message-ID: <000b01cbd713$658693a0$3093bae0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lars-Peter Clausen wrote:
> 
> This allows the regulator core to disable all regulators which are not in
use
> at the end of the kernel init phase.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/arm/mach-s3c2440/mach-gta02.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/mach-gta02.c
b/arch/arm/mach-s3c2440/mach-
> gta02.c
> index 01e0930..2682592 100644
> --- a/arch/arm/mach-s3c2440/mach-gta02.c
> +++ b/arch/arm/mach-s3c2440/mach-gta02.c
> @@ -590,6 +590,8 @@ static void __init gta02_machine_init(void)
> 
>  	platform_add_devices(gta02_devices, ARRAY_SIZE(gta02_devices));
>  	pm_power_off = gta02_poweroff;
> +
> +	regulator_has_full_constraints();
>  }
> 
> 
> --

Ok, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
