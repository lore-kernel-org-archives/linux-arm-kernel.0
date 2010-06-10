From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Jun 2010 01:36:06 +0400
Subject: [PATCH 02/10] arm/zImage: some comments for __armv3_mpu_cache_on
In-Reply-To: <1276165636-20150-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4C115AC6.1040801@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Uwe Kleine-K?nig wrote:

> __armv3_mpu_cache_on seems broken.  As there is noone around who knows
> about these machines just keep the code as is but point out the strange
> things.

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/compressed/head.S |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 390aa92..384150b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -396,12 +396,15 @@ __armv3_mpu_cache_on:
>  
>  		mov	r0, #0
>  		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
> +		/* ?? ARMv3 MMU doesn not allow reading the control register, does this really work on ARMv3 MPU? */

    Only "does not".

WBR, Sergei
