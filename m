From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 23 May 2017 21:07:10 +0100
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
In-Reply-To: <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
 <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
Message-ID: <20170523210710.4e84dd2d@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> yep hardcoded max 4 where in probe first free space is found and used
> (range 0-3) but still max3100s statically allocated.
> Shouldn't be this also dynamically allocated?

The code to do the dynamic allocation would be larger than the array of
pointers for the sane worst case.

> I am not quite sure how exactly you want to do this via DT.

Count the number of DT entries for this kind of port and allocate that
many ?

> 
> Also what do you think is a safe maximum number? This is fpga - hundreds
> of pins which can do just uart.
> 
> > There are lots of options better than breaking the "one kernel many
> > platforms" model.  
> 
> Another options is also module parameter and dynamically allocated array
> in cdns_uart_init.

For a given platform the number is constant and they need to be
described, so it seems to make no sense to put it anywhere other than the
DT for that platform.

Why should users have to pass magic config options not use DT as
intended ?

Alan
