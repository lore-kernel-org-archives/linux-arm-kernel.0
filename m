From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Mon, 31 Aug 2009 23:33:12 +0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
	<4A9C0136.3080102@gabaedevelopment.com>
	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
Message-ID: <20090831233312.2d2a6676@realm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
> And how do I turn on the PMC clocks for the GPIO?

Assigning gpio pin PC6 to TIOB2 peripheral is only a part of the work.
Timer counters may operate in different modes. Take a look at
the datasheet for at91sam9260, timer counters are covered in chapter 34. 
It looks like 'waveform mode' is what you need (see 34.5.10, 34.5.11).
Before you get desired output on PC6 pin you will have to turn on
waveform operating mode for TIOB2 and to configure its wave shapes.
 
Thanks,
Sergey
