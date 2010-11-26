From: phorton@bitbox.co.uk (Peter Horton)
Date: Fri, 26 Nov 2010 10:09:52 +0000
Subject: MX51: add FIQ support for TZIC
In-Reply-To: <20101125203819.GK4693@pengutronix.de>
References: <20101125151909.GB19343@numbat.localnet>
	<20101125203819.GK4693@pengutronix.de>
Message-ID: <4CEF8770.90201@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/2010 20:38, Uwe Kleine-K?nig wrote:
>> +
>> +	return 0;
>> +}
>> +
>> +EXPORT_SYMBOL(mxc_set_irq_fiq);
> Hmm, I guess this makes it impossible to compile avic.c and tzic.c with
> FIQ=y into a single binary.
>

What about adding a local IRQ_TYPE_FAST and implementing 
irq_chip.set_type(), for both the AVIC and the TZIC, to do the switch 
between IRQ and FIQ mode ?

mxc_set_irq_fiq() would then just become a wrapper round irq_set_type().

P.
