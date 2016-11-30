From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 12:37:17 +0100
Subject: [PATCH] soc: ti: qmss: fix the case when !SMP
In-Reply-To: <20161129221508.10551-1-grygorii.strashko@ti.com>
References: <20161129221508.10551-1-grygorii.strashko@ti.com>
Message-ID: <5501170.dgvo5UdPBX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 29, 2016 4:15:08 PM CET Grygorii Strashko wrote:
>                 range->num_irqs++;
>  
> -               if (oirq.args_count == 3)
> +               if (IS_ENABLED(SMP) && oirq.args_count == 3)
>                         range->irqs[i].cpu_map =
>                                 (oirq.args[2] & 0x0000ff00) >> 8;
> 

I think you mean CONFIG_SMP, not SMP. With the change above, the
code will never be executed.

	Arnd
