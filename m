From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 06 May 2014 17:24:33 +0200
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <201405061718.54012.arnd@arndb.de>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <20140505223839.45778902@skate> <536800A8.7090801@intel.com>
 <201405061718.54012.arnd@arndb.de>
Message-ID: <1399389873.29530.3.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 06.05.2014, 17:18 +0200 schrieb Arnd Bergmann:
> On Monday 05 May 2014, Alexander Duyck wrote:
> > Glad to hear that this is working on your ARM platform as expected.
> > 
> > I believe the issue Shiv is having is due to a problem with the specific
> > platform as the IGB device is reporting a Data Link Protocol error via
> > AER and I believe this is what is causing his platform issues.  On
> > enabling BME the device is likely signalling a Fatal Error message in
> > response to the DLP error.  The original error he was seeing was:
> > 
> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> 
> This isn't too uncommon. There are a couple of traditional PCI host drivers
> that register an imprecise external abort handler to catch this and
> then look at the host controller registers.
> 
> Out of the pcie hosts, only drivers/pci/host/pci-imx6.c catches
> this error, but it then goes on to ignore it, not even printing
> a message about it.
> 
I think this handler is mostly there to handle the imprecise external
abort happening on DW pcie IP if the bus scan tries to access an
non-existent device. That's why it silently ignores this error.

BTW: I can confirm that igb i350 works on i.MX6.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
