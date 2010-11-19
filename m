From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 19 Nov 2010 11:23:21 +0200
Subject: [PATCH] ARM: s3x24xx: Fix gpiochip_add complaining.
In-Reply-To: <1290158139-16105-1-git-send-email-marek.belisko@open-nandra.com>
References: <1290158139-16105-1-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <201011191123.22255.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 November 2010 11:15:39 Marek Belisko wrote:
> Make mini2440_defconfig. During kernel startup there is:
> gpiochip_add: gpios 288..303 (GPIOK) failed to register
> gpiochip_add: gpios 320..334 (GPIOL) failed to register
> gpiochip_add: gpios 352..353 (GPIOM) failed to register
>
> because s3c2440 doesn't have following gpios. Gpios are
> available only at upper cpu version (s3c2443).

These warnings are harmless, and your patch prevents building single binary 
kernel for all s3c24xx socs (however, it's already broken by latest pull-
up/pull-down changes)

Regards
Vasily
