From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 10 Jun 2010 18:31:52 +0800
Subject: [PATCH 01/10] arm/zImage: don't hard code the stack size twice
In-Reply-To: <1276165636-20150-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTinvvP7GFMHDoaw3SgIetd42Yyho1r9oMuiSIlnV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> ?arch/arm/boot/compressed/head.S | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index c5191b1..390aa92 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -315,7 +315,7 @@ LC0: ? ? ? ? ? ? ? ?.word ? LC0 ? ? ? ? ? ? ? ? ? ? @ r1
> ? ? ? ? ? ? ? ?.word ? _image_size ? ? ? ? ? ? @ r6
> ? ? ? ? ? ? ? ?.word ? _got_start ? ? ? ? ? ? ?@ r11
> ? ? ? ? ? ? ? ?.word ? _got_end ? ? ? ? ? ? ? ?@ ip
> - ? ? ? ? ? ? ? .word ? user_stack+4096 ? ? ? ? @ sp
> + ? ? ? ? ? ? ? .word ? user_stack_end ? ? ? ? ?@ sp
> ?LC1: ? ? ? ? ? .word ? reloc_end - reloc_start
> ? ? ? ? ? ? ? ?.size ? LC0, . - LC0
>
> @@ -1070,3 +1070,4 @@ reloc_end:
> ? ? ? ? ? ? ? ?.align
> ? ? ? ? ? ? ? ?.section ".stack", "w"
> ?user_stack: ? ?.space ?4096
> +user_stack_end:

This one looks OK to me.

Acked-by: Eric Miao <eric.miao@canonical.com>
