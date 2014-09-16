From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 16 Sep 2014 16:05:08 -0700
Subject: [PATCH v10 5/9] arm: omap1: Migrate debug_ll macros to use 8250.S
In-Reply-To: <20140916225810.GA1273@drone.musicnaut.iki.fi>
References: <1410907588-19957-1-git-send-email-daniel.thompson@linaro.org>
 <1410907588-19957-6-git-send-email-daniel.thompson@linaro.org>
 <20140916225810.GA1273@drone.musicnaut.iki.fi>
Message-ID: <5418C224.8050504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/14 15:58, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Sep 16, 2014 at 11:46:24PM +0100, Daniel Thompson wrote:
>> +	config DEBUG_OMAP1UART1
>> +		bool "Kernel low-level debugging via OMAP1 UART1"
>> +		depends on ARCH_OMAP1
>> +		select DEBUG_UART_8250
>> +		help
>> +		  Say Y here if you want kernel low-level debugging support
>> +		  on OMAP1 based platforms (expect OMAP730) on the UART1.
>                                             ^^^^^^
> 
>> +		select DEBUG_UART_8250
>> +		help
>> +		  Say Y here if you want kernel low-level debugging support
>> +		  on OMAP1 based platforms (expect OMAP730) on the UART2.
>                                             ^^^^^^
> 
>> +		select DEBUG_UART_8250
>> +		help
>> +		  Say Y here if you want kernel low-level debugging support
>> +		  on OMAP1 based platforms (expect OMAP730) on the UART3.
>                                             ^^^^^^
> 
> I already commented earlier, that "expect" here is probably a typo?

I'm extremely sorry to have overlooked your previous comment. There's
certainly no question I read your previous e-mail because because I
copied your Tested-by: from it.

I will fix this (and also grep all other patches in the set to make sure
I haven't copied the typo anywhere else).


Daniel.
