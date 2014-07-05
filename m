From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Jul 2014 20:29:40 +0200
Subject: [PATCH v2 4/4] arm: pxa: add non device-tree timer link to
 clocksource
In-Reply-To: <1404558781-9537-4-git-send-email-robert.jarzmik@free.fr>
References: <1404558781-9537-1-git-send-email-robert.jarzmik@free.fr>
 <1404558781-9537-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <5284586.j08GjTMeo6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 July 2014 13:13:01 Robert Jarzmik wrote:
>  EXPORT_SYMBOL(get_clock_tick_rate);
>  
>  /*
> + * For non device-tree builds, keep legacy timer init
> + */
> +extern void pxa_timer_nodt_init(int irq, void __iomem *base,
> +                          unsigned long clock_tick_rate);
> +void pxa_timer_init(void)
> +{
> +       pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000),
> +                           get_clock_tick_rate());
> +}
> +

I think it would be better to move the extern declaration into 
a new header file, e.g. include/clocksource/pxa.h.

	Arnd
