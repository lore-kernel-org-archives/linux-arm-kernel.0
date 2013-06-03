From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jun 2013 00:34:46 +0200
Subject: [PATCH v3 10/11] ARM: mmp: avoid to use cpu_is_xxx in timer
In-Reply-To: <1370251845-31373-11-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
 <1370251845-31373-11-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201306040034.47041.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013, Haojian Zhuang wrote:
>  void __init mmp_dt_init_timer(void)
>  {
>         struct device_node *np;
> +       struct clk *clk;
>         int irq, ret;
> +       u32 rate = 0;
>  
>         np = of_find_matching_node(NULL, mmp_timer_dt_ids);
> -       if (!np) {
> -               ret = -ENODEV;
> -               goto out;

Please use CLOCKSOURCE_OF_DECLARE() here and call clocksource_of_init()
in the platform code, rather than calling mmp_dt_init_timer directly.

	Arnd
