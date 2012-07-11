From: pavel@denx.de (Pavel Machek)
Date: Wed, 11 Jul 2012 23:08:37 +0200
Subject: [PATCH v5] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
References: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
Message-ID: <20120711210837.GA32489@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>

Not that it matters, but it should probably be from: me, since I did
the original version...

> Make a common device tree glue for clocksource/dw_apb_timer.
> Move mach-picoxcell/time.c to be a generic device tree application
> of the dw_apb_timer.
> 
> Configure mach-picoxcell to use the dw_apb_timer_of device tree
> implementation in drivers/clocksource.

> @@ -25,11 +32,12 @@ static void timer_get_base_and_rate(struct device_node *np,
>  	if (!*base)
>  		panic("Unable to map regs for %s", np->name);
>  
> -	if (of_property_read_u32(np, "clock-freq", rate))
> -		panic("No clock-freq property for %s", np->name);
> +	if (of_property_read_u32(np, "clock-freq", rate) &&
> +		of_property_read_u32(np, "clock-frequency", rate))
> +		panic("No clock-frequency property for %s", np->name);
>  }
>  

But this should be ||, not &&, I guess.

Thanks for the patch,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
