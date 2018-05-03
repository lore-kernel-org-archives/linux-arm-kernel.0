From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 3 May 2018 14:36:03 +0200
Subject: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
In-Reply-To: <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
 <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
Message-ID: <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2018 21:16, Sebastian Andrzej Siewior wrote:
> On 2018-04-27 12:31:52 [+0200], Richard Genoud wrote:
>> Hi Sebastian,
> Hi,
> 
>>> If this is unknown and a bisect is requested, please let me know.
>> Indeed, this will be appreciated.
>> I'm quite curious to find the commit that led to this.
> 
> commit 761ed4a94582ab291aa24dcbea4e01e8936488c8
> Author: Rob Herring <robh@kernel.org>
> Date:   Mon Aug 22 17:39:10 2016 -0500
> 
>     tty: serial_core: convert uart_close to use tty_port_close
>     
>     tty_port_close handles much of the common parts of tty close. Convert
>     uart_close to use it and move the serial_core specific parts into
>     tty_port.shutdown function. This will be needed to use tty_port functions
>     directly from in kernel clients.
>     
>     This change causes ops->stop_rx() to be called after uart_wait_until_sent()
>     is called which I think should be fine. Otherwise, the sequence of the
>     close should be the same.
>     
>     Cc: Peter Hurley <peter@hurleysoftware.com>
>     Signed-off-by: Rob Herring <robh@kernel.org>
>     Acked-by: Alan Cox <alan@linux.intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The thread starts at
>   https://www.spinics.net/lists/linux-serial/msg30070.html
>   http://lkml.kernel.org/r/20180426150625.q5tqcb7fzchvkb5d at linutronix.de

Thanks for this hunting session !
Could resend your patch with Fixes: in the commit message ?

BTW, I didn't manage to reproduce the behavior you describe, could you
give me your .config and describe a little more how you manage to
trigger this bug ?
(do you use the console on serial debug ? which board ? )


Thanks !
