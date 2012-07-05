From: marex@denx.de (Marek Vasut)
Date: Thu, 5 Jul 2012 18:23:26 +0200
Subject: MX28 poweroff issue
In-Reply-To: <20120705160855.GA20175@S2101-09.ap.freescale.net>
References: <201207040030.36713.marex@denx.de>
 <20120704151944.GB18739@n2100.arm.linux.org.uk>
 <20120705160855.GA20175@S2101-09.ap.freescale.net>
Message-ID: <201207051823.26243.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

[...]

> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 19c95ea..e41edea 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -247,7 +247,8 @@ void machine_shutdown(void)
>  void machine_halt(void)
>  {
>         machine_shutdown();
> -       while (1);
> +       while (1)
> +               msleep(1);

Won't mdelay() be better?

It removes the warning, but can't some other stray interrupt trigger it again?

>  }

Best regards,
Marek Vasut
