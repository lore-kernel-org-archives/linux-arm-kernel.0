From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Sun, 22 Jan 2012 20:45:24 +0100
Subject: [RFC PATCH 06/11] Cortex-M3: Add base support for Cortex-M3
In-Reply-To: <1327230817-12855-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
 <1327230817-12855-6-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAHXqBFKYVOpeLxK_Fc_fcaa1ehoq2wJM1LnfEGvWnENzk4GqLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/22 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -100,7 +100,7 @@ __mmap_switched:
> ? ? ? ?str ? ? r2, [r6] ? ? ? ? ? ? ? ? ? ? ? ?@ Save atags pointer
> ? ? ? ?cmp ? ? r7, #0
> ? ? ? ?bicne ? r4, r0, #CR_A ? ? ? ? ? ? ? ? ? @ Clear 'A' bit
> - ? ? ? stmneia r7, {r0, r4} ? ? ? ? ? ? ? ? ? ?@ Save control register values
> + ? ? ? stmiane r7, {r0, r4} ? ? ? ? ? ? ? ? ? ?@ Save control register values
> ? ? ? ?b ? ? ? start_kernel
> ?ENDPROC(__mmap_switched)
>

This fixes one of previous patches, doesn't it?

Best Regards,
Micha? Miros?aw
