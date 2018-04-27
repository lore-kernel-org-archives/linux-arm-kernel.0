From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 27 Apr 2018 12:31:52 +0200
Subject: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
In-Reply-To: <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
Message-ID: <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 26/04/2018 17:12, Sebastian Andrzej Siewior wrote:
> On 2018-04-26 17:06:25 [+0200], To linux-serial at vger.kernel.org wrote:
>> It seems not to happen in v4.1.51 but it happens in v4.9 and v4.17-rc2
>> so if it broke accidentally it was not recently.
> 
> This is what I used to check:
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -170,7 +170,7 @@ void free_tty_struct(struct tty_struct *tty)
>  	put_device(tty->dev);
>  	kfree(tty->write_buf);
>  	tty->magic = 0xDEADDEAD;
> -	kfree(tty);
> +	strcpy(tty->name, "GONE");
>  }
>  
>  static inline struct tty_struct *file_tty(struct file *file)
> 
> If this is unknown and a bisect is requested, please let me know.
Indeed, this will be appreciated.
I'm quite curious to find the commit that led to this.

Thanks !

> 
> Sebastian
> 

Richard
