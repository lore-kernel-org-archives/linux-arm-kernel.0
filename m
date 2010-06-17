From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 17 Jun 2010 17:37:52 +0800
Subject: [PATCH 05/10] arm/zImage: annotate debug functions about
	corrupted registers
In-Reply-To: <1276165636-20150-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTingMRjp-7IUddg7gV9eXVBLRmd598MqH7ykbeCk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Not sure if this is absolutely necessary, though.

> ---
> ?arch/arm/boot/compressed/head.S | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index f8a210b..dbeeb56 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1005,6 +1005,7 @@ __armv3_mpu_cache_flush:
> ?phexbuf: ? ? ? .space ?12
> ? ? ? ? ? ? ? ?.size ? phexbuf, . - phexbuf
>
> +@ phex corrupts {r0, r1, r2, r3}
> ?phex: ? ? ? ? ?adr ? ? r3, phexbuf
> ? ? ? ? ? ? ? ?mov ? ? r2, #0
> ? ? ? ? ? ? ? ?strb ? ?r2, [r3, r1]
> @@ -1019,6 +1020,7 @@ phex: ? ? ? ? ? ? adr ? ? r3, phexbuf
> ? ? ? ? ? ? ? ?strb ? ?r2, [r3, r1]
> ? ? ? ? ? ? ? ?b ? ? ? 1b
>
> +@ puts corrupts {r0, r1, r2, r3}
> ?puts: ? ? ? ? ?loadsp ?r3, r1
> ?1: ? ? ? ? ? ? ldrb ? ?r2, [r0], #1
> ? ? ? ? ? ? ? ?teq ? ? r2, #0
> @@ -1033,12 +1035,14 @@ puts: ? ? ? ? ? loadsp ?r3, r1
> ? ? ? ? ? ? ? ?teq ? ? r0, #0
> ? ? ? ? ? ? ? ?bne ? ? 1b
> ? ? ? ? ? ? ? ?mov ? ? pc, lr
> +@ putc corrupts {r0, r1, r2, r3}
> ?putc:
> ? ? ? ? ? ? ? ?mov ? ? r2, r0
> ? ? ? ? ? ? ? ?mov ? ? r0, #0
> ? ? ? ? ? ? ? ?loadsp ?r3, r1
> ? ? ? ? ? ? ? ?b ? ? ? 2b
>
> +@ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}
> ?memdump: ? ? ? mov ? ? r12, r0
> ? ? ? ? ? ? ? ?mov ? ? r10, lr
> ? ? ? ? ? ? ? ?mov ? ? r11, #0
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
