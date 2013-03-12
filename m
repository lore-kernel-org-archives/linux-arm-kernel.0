From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 18:54:45 +0000
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303121854.45864.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Haojian Zhuang wrote:
> 
> -       aliases {
> -               arm,timer-primary = &timer2;
> -               arm,timer-secondary = &timer1;
> -       };
> -
>         chosen {
>                 bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
>         };
> @@ -29,10 +24,14 @@
>  
>         timer1: timer at 13000100 {
>                 compatible = "arm,sp804", "arm,primecell";
> +               arm,sp804-clockevent = <0>;
> +               status = "ok";
>         };

I would prefer to keep the old way of doing this. The "aliases" node is
meant for configuration, while the timer device itself should not care
whether it is used as a clockevent or clocksource or some other device.

We could probably change the identifiers in the aliases to
"linux,clocksource" and "linux,clockevents" instead of
"arm,timer-primary" and "arm,timer-secondary".

	Arnd
