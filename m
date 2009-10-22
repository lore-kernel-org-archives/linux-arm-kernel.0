From: matt@0xlab.org (Matt Hsu)
Date: Fri, 23 Oct 2009 00:41:01 +0800
Subject: MXC MMC driver and SDIO peripherals
In-Reply-To: <20091021205156.GO14091@buzzloop.caiaq.de>
References: <20091021192038.GK14091@buzzloop.caiaq.de>	<1256156119.8469.40.camel@localhost.localdomain>
	<20091021205156.GO14091@buzzloop.caiaq.de>
Message-ID: <4AE08B1D.7010307@0xlab.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>
> I didn't really debug it yet, but from what I see in the sources, the
> maximum block size is 2048. The hardware is connected via the 4-wire
>   
Hi Daniel,

Did you try to run the driver with 1-Bit mode?

Maybe you can try to have debug routine to report the IRQ status for 
this sdhc controller.
Then you could know what's wrong with firmware downloading or command 
issuing.
Since the card detection looks fine according to your message.

If it tells you the DATA CRC error, then you can try to operate the SDIO 
in 1-Bit mode.
If it tells you the CMD CRC error, probably the strength of SDIO_CLK is 
not enough, you
need to have either internal pull-up or external resistor.

Cheers,
Matt
> interface (+clk, +cmd). The system I tried that on has a MMC slot where
> I can plug in either the WLAN eval kit or a memory card, and the latter
> works just fine, which tells me that at least the pin config and the
> hardware can't be entirely wrong.
>
>   
>> What is the debug output of the MMC stack when loading the
>> module for your SDHC?
>>     
>
> Exactly one line ;)
>
> [    1.340000] i.MX SDHC driver
>
>
> Daniel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   
