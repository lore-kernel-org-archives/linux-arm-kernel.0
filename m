From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Feb 2011 01:53:02 +0800
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110211003533.GA9151@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
	<201102042126.52701.arnd@arndb.de>
	<20110211003533.GA9151@S2100-06.ap.freescale.net>
Message-ID: <20110213175300.GA10271@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Feb 11, 2011 at 08:35:34AM +0800, Shawn Guo wrote:
> 
> > > +	unsigned			present:1;
> > 
> > Your card detection by polling through this variable is
> > really bad for power management. Is there really no interrupt
> > that gets triggered when installing or removing a card?
> > 
> Good point.  Will try to use interrupt.
> 
I'm trying to use interrupt for card detection.  But unfortunately,
I got stuck for some reason.

There is a known issue that mx28 gpio interrupt from bank0 can not
work, because the pin bank0 irq number 127 was used in
get_irqnr_and_base (entry-macro.S) to tell there is no pending
interrupt any more.

The mmc0 cd pin has no problem to trigger interrupt, as it's GPIO_2_9.
But mmc1 cd pin can not, because it's GPIO_0_20.

So I probably have to stay with polling.

Regards,
Shawn
