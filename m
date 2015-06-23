From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 23 Jun 2015 10:25:14 +0200 (CEST)
Subject: [PATCH v2] trace/events: add chip name and hwirq to irq entry
 tracepoint
In-Reply-To: <1435014310-2080-1-git-send-email-ankgupta@codeaurora.org>
References: <1435014310-2080-1-git-send-email-ankgupta@codeaurora.org>
Message-ID: <alpine.DEB.2.11.1506231024250.4037@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jun 2015, Ankit Gupta wrote:

> Add chip name and hw-irq number to the trace_irq_handler_entry()
> tracepoint. When tracing interrupt events the chip-name and hw-irq
> numbers are stable and known in advance. This makes them a better
> choice as a filtering criteria for the trace buffer dump. On the
> flipside, the os-irq numbers are dynamically allocated which makes
> them difficult to use for the same purpose.
> 
> Dump messages will look like:
> ...irq_handler_entry: irq=22 name=msm_serial0 domain=GIC hwirq=140

I can't see the domain name being captured/printed in the code below.
 
> -	TP_printk("irq=%d name=%s", __entry->irq, __get_str(name))
> +	TP_printk("irq=%d name=%s chip_name=%s hwirq=%ld", __entry->irq,
> +	  __get_str(name), show_chip_name(__entry->irq),
> +	  show_hwirq(__entry->irq))
>  );

Thanks,

	tglx
