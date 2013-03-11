From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 10 Mar 2013 17:17:47 -0700 (PDT)
Subject: [PATCH v2 5/7] ARM: mach-shmobile: sh73a0: Setup the timer CMT10
 using DT
In-Reply-To: <1362742181-19111-6-git-send-email-hechtb+renesas@gmail.com>
References: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
 <1362742181-19111-6-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <87y5duhjru.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Bastian

1 question

> We can now use the Device Tree for bringing up our timer device CMT10 on
> the SoC sh73a0.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
(snip)
>  /* TMU */
>  static struct sh_timer_config tmu00_platform_data = {
>  	.name = "TMU00",
> @@ -913,7 +882,6 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
>  	&scif6_device,
>  	&scif7_device,
>  	&scif8_device,
> -	&cmt10_device,
>  };

I didn't test this patch,
but setup-sh73a0.c :: sh73a0_devices_dt is
used from sh73a0_add_standard_devices() or sh73a0_add_early_devices(),
and it is used from board-kzm9g.c (not -reference.c).

Does board-kzm9g.c still works ?
Is it better that sh73a0_early_devices[] has it ?


Best regards
---
Kuninori Morimoto
