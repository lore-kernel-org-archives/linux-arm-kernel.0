From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 09:10:26 +0000
Subject: [PATCH] ARM: SAMSUNG: Add clk enable/disable of pwm
In-Reply-To: <019301cc9a08$17c69d50$4753d7f0$%kim@samsung.com>
References: <1319505701-9784-1-git-send-email-jy0922.shim@samsung.com>
	<012701cc99cc$300dca50$90295ef0$%kim@samsung.com>
	<4EB1FB58.9050503@samsung.com>
	<018e01cc99fc$bb4d5ec0$31e81c40$%kim@samsung.com>
	<4EB24886.8080002@samsung.com>
	<CAH9JG2XFALdd_JVSQW4rjCDCgLL9sgf_GVurVDoGJa-SwXmB5Q@mail.gmail.com>
	<CAH9JG2X9dXe2cG6qvqM6GuTuC6xc0wBYSsvba=zbbmQD7BqYXg@mail.gmail.com>
	<019301cc9a08$17c69d50$4753d7f0$%kim@samsung.com>
Message-ID: <20111103091026.GH12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 06:08:03PM +0900, Kukjin Kim wrote:
> diff --git a/arch/arm/plat-samsung/pwm-clock.c b/arch/arm/plat-samsung/pwm-clock.c
> index a35ff3b..37a159b 100644
> --- a/arch/arm/plat-samsung/pwm-clock.c
> +++ b/arch/arm/plat-samsung/pwm-clock.c
> @@ -449,6 +449,8 @@ __init void s3c_pwmclk_init(void)
>  		return;
>  	}
>  
> +	clk_enable(clk_timers);

Error checking?  clk_prepare() as well?
