From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Jun 2015 21:21:59 +0000 (UTC)
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
In-Reply-To: <20150601180429.GA30984@atomide.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <20150601180429.GA30984@atomide.com>
Message-ID: <alpine.DEB.2.02.1506012120020.14902@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Jun 2015, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [150601 10:45]:
> 
> > http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt
> 
> OK somehow 3517evm is listed under "skip" there? 

Yep that board is down right now; something's wrong with it and I haven't 
had the time to figure out whether it's fixable, or if it's fried.

> > The best way to make this work IMHO would be for us not to accept any new 
> > feature addition patches as long as there are warnings reported in the 
> > test results.  The only real exception that I would foresee is if those 
> > warnings are due to something outside of our control, e.g., a crappy 
> > bootloader, as I suspect the USB_OTG initiator warnings are for the 
> > CM-T3517.
> 
> Right. Also seems we should diff dmesg output too (after stripping out
> the timestamps). Pretty much the only things that should change are
> the sysfs paths for devices in the dmesg output unless some warnings
> get fixed. That output probably still also needs to be manually looked
> at though..

Yep, there are still some other minor loose ends to be tied up too that 
don't show up as full warnings, such as the broken UART4 idle protocol 
integration on AM35xx...

- Paul
