From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 2 Jan 2011 21:30:23 +0100
Subject: zaurus bluetooth regression
In-Reply-To: <20110102204532.GA12860@elf.ucw.cz>
References: <20110102204532.GA12860@elf.ucw.cz>
Message-ID: <20110102203023.GA1545@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> It seems this commit
> 
> commit 7a56aa45982bb87bfca98a2832b5ae782c03364a
...
> ...is responsible for my bluetooth problems on zaurus -- at least
> bisect pointed to it,  as I use 16C950-based bluetooth card, it seems
> very logical. I'll try 2.6.37-rc8 with that patch reverted...
> 

And yes, 37-rc8 with that reverted results in working bluetooth, so
yrs, that patch is responsible.

								Pavel

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 09ef570..bc8ed4b 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -241,7 +241,7 @@ static const struct serial8250_config uart_config[] = {
>  		.fifo_size	= 128,
>  		.tx_loadsz	= 128,
>  		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> -		.flags		= UART_CAP_FIFO,
> +		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
>  	},
>  	[PORT_16654] = {
>  		.name		= "ST16654",
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
