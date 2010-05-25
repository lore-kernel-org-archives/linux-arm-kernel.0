From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Tue, 25 May 2010 10:09:37 +0200
Subject: [PATCH 2/2] ARM: Fix MMC power management on Acer n30 / n35
In-Reply-To: <4BFB2638.2020402@vscht.cz>
References: <4BFB2443.1040701@vscht.cz> <4BFB2638.2020402@vscht.cz>
Message-ID: <4BFB85C1.70204@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 25.5.2010 03:22, Pinkava J. napsal(a):
> Exchange on and off state, MMC is working even if "powered off", but when comes
> to write it causes random failures, most frequently zeroes first/all sector(s).
Sorry for mess, this is idependend on previous patch and should be included.

(Or removed patch named:
ARM: n30: Add support for power on/off on Acer n30 / Acer n35 MMC card reader
)


> 
> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
> ---
>  arch/arm/mach-s3c2410/mach-n30.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
> index 41f299d..6c3456c 100644
> --- a/arch/arm/mach-s3c2410/mach-n30.c
> +++ b/arch/arm/mach-s3c2410/mach-n30.c
> @@ -357,11 +357,11 @@ static void n30_sdi_set_power(unsigned char power_mode,
> unsigned short vdd)
>  	switch (power_mode) {
>  	case MMC_POWER_ON:
>  	case MMC_POWER_UP:
> -		gpio_set_value(S3C2410_GPG(4), 1);
> +		gpio_set_value(S3C2410_GPG(4), 0);
>  		break;
>  	case MMC_POWER_OFF:
>  	default:
> -		gpio_set_value(S3C2410_GPG(4), 0);
> +		gpio_set_value(S3C2410_GPG(4), 1);
>  		break;
>  	}
>  }
