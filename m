From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 29 Mar 2011 11:50:31 +0300
Subject: [PATCH 4/4] s3c2440: mini2440: Enable the backlight LED earlier
	at boot time.
In-Reply-To: <1301380363-3282-5-git-send-email-marek.belisko@open-nandra.com>
References: <1301380363-3282-1-git-send-email-marek.belisko@open-nandra.com>
	<1301380363-3282-5-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <201103291150.32097.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2011 09:32:43 Marek Belisko wrote:
> Code overtaken from:
> http://repo.or.cz/w/linux-2.6/mini2440.git
> 
> Use flag that allows s3c24xx LED to start in the "on" state.
> This is necesary to enable LCD backlight during early boot stage.

Why are you still using leds-s3c24xx driver? mini2440 should work OK with 
leds-gpio. Anyway, looks like patch should be splitted into 2 patches: first 
adds flag to leds-s3c24xx driver, second enables this flag for mini2440.

Regards
Vasily

> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> Signed-off-by: Michel Pollet <buserror@gmail.com>
> ---
>  arch/arm/mach-s3c2410/include/mach/leds-gpio.h |    1 +
>  arch/arm/mach-s3c2440/mach-mini2440.c          |    1 +
>  drivers/leds/leds-s3c24xx.c                    |    6 +++++-
>  3 files changed, 7 insertions(+), 1 deletions(-)
