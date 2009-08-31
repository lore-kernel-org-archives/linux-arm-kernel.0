From: smunnings@gabaedevelopment.com (Stephen Munnings)
Date: Mon, 31 Aug 2009 15:58:50 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <20090831233312.2d2a6676@realm>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>	<4A9C0136.3080102@gabaedevelopment.com>	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
	<20090831233312.2d2a6676@realm>
Message-ID: <4A9C2B7A.7070306@gabaedevelopment.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergey Matyukevich wrote:
> Hi,
>  
>   
>> And how do I turn on the PMC clocks for the GPIO?
>>     
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
>   
hmmmm....

PCK0 is *not*  a TC pin - it is a clock output from the Power Management 
Controller.
(Section 25.6)
It should be as easy as dividing down one of the primary clock sources 
and then enabling
the appropriate GPIO pin as the appropriate peripheral.

Ahah - there is the problem.....  PCK0 is not available on PC6 - it must 
be set as peripheral B
on pin PC1 or PB30 as Peripheral A - no other choices available...

PC6 is indeed TIOB2 (one of the counter timers)
