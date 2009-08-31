From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Tue, 1 Sep 2009 00:35:46 +0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <b7beacff65dbf47b5e36c3480ec11085@colcan.ca>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
	<4A9C0136.3080102@gabaedevelopment.com>
	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
	<20090831233312.2d2a6676@realm>
	<b7beacff65dbf47b5e36c3480ec11085@colcan.ca>
Message-ID: <20090901003546.14313e09@realm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> So are the following statements correct?
> 
> 1. The pck0 clock I've been playing with has nothing to do with the
> clock I want on PC6 (TIOB2).

Yes. PCK's (programmable clocks) are assigned to different pins:  
PB30, PC1 for PCK0 and to  PB31, PC2 for PCK1. 
For PCK see ch. 26 of at91sam9260 datasheet.

> 2. I have to use instead the "tc2_clk" as defined in
> arch/arm/mach-at-91/at91sam9260.c.

Yes

> 3. I have to access the TC_CMR register directly to set things up. I
> mean, there are no macros already defined to access these structures.

You have to 'ioremap' required registers and write to those
registers directly using memory-writing macroses iowriteXX.

But at first decide what you need, TIOB or PCK. If you don't need all
the power of Ryan Mallon's pwm driver (see below in the thread) and
all you need is clocking output on GPIO pin, then you might be happy
with PCK. Note that PMC_PCK registers allows several dividers, if
original clock is too high.

Sergey 
