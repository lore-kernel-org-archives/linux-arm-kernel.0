From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 29 Sep 2014 15:39:18 +0200
Subject: [PATCH 02/16] tty: serial: 8250_core: add run time pm
In-Reply-To: <20140929094620.GE13952@ci00147.xsens-tech.local>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-3-git-send-email-bigeasy@linutronix.de>
 <20140929094620.GE13952@ci00147.xsens-tech.local>
Message-ID: <20140929133918.GE13142@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Frans Klaver | 2014-09-29 11:46:20 [+0200]:

>On Wed, Sep 10, 2014 at 09:29:57PM +0200, Sebastian Andrzej Siewior wrote:
>> +/*
>> + * This two wrapper ensure, that enable_runtime_pm_tx() can be called more than
>
>These two wrappers ensure that enable_runtime_pm_tx() ...
fixed

>> @@ -1469,7 +1531,12 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>>  
>>  	DEBUG_INTR("THRE...");
>>  
>> -	if (uart_circ_empty(xmit))
>> +	/*
>> +	 * With RPM enabled, we have to wait once the FIFO is empty before the
>
>s,once,until,? Or do I not understand the sentence correctly?
No, you understand it correct. "until" is the better word here.

Sebastian
