From: psanchez@fosstel.com (Pedro I. Sanchez)
Date: Mon, 31 Aug 2009 16:03:42 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <20090831233312.2d2a6676@realm>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
	<4A9C0136.3080102@gabaedevelopment.com>
	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
	<20090831233312.2d2a6676@realm>
Message-ID: <b7beacff65dbf47b5e36c3480ec11085@colcan.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Aug 2009 23:33:12 +0400, Sergey Matyukevich <geomatsi@gmail.com>
wrote:
> Hi,
>  
>> And how do I turn on the PMC clocks for the GPIO?
> 
> Assigning gpio pin PC6 to TIOB2 peripheral is only a part of the work.
> Timer counters may operate in different modes. Take a look at
> the datasheet for at91sam9260, timer counters are covered in chapter 34. 
> It looks like 'waveform mode' is what you need (see 34.5.10, 34.5.11).
> Before you get desired output on PC6 pin you will have to turn on
> waveform operating mode for TIOB2 and to configure its wave shapes.
>  
> Thanks,
> Sergey

Thanks Sergey,

So are the following statements correct?

1. The pck0 clock I've been playing with has nothing to do with the clock I
want on PC6 (TIOB2).

2. I have to use instead the "tc2_clk" as defined in
arch/arm/mach-at-91/at91sam9260.c.

3. I have to access the TC_CMR register directly to set things up. I mean,
there are no macros already defined to access these structures.


Thanks,

-- 
Pedro
