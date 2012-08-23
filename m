From: stigge@antcom.de (Roland Stigge)
Date: Thu, 23 Aug 2012 10:59:00 +0200
Subject: [PATCH 1/2] usb: change the dependency chain for LPC32XX and
 ISP1301
In-Reply-To: <5035E9D0.9020107@linutronix.de>
References: <Pine.LNX.4.44L0.1208221537260.1328-100000@iolanthe.rowland.org>
 <50355A2C.9010505@antcom.de> <5035D9E0.1000905@linutronix.de>
 <5035E75F.5080801@antcom.de> <5035E9D0.9020107@linutronix.de>
Message-ID: <5035F0D4.9020001@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 10:29 AM, Sebastian Andrzej Siewior wrote:
>> For the PNX4008 removal - should I already post a patch to build the
>> respective changes on top of, without PNX4008 references?
> 
> If nobody cares about PNX4008 and nobody tested if it actually works in
> the OHCI mode I don't see the point in keeping it around especially if
> there are rumors to remove the arch.
> 
> It would be nice, if you could manage to compile this thingy without
> I2C. In the end one could attach something different than isp1301, no?
> So I think, in the perfect world you would probe for your phy and
> notice that it is not there and print a message: "Dude! Select isp1301
> for OHCI, aight?!"

Currently, we really need I2C for OHCI on LPC32XX, so actually need to
depend on it. Removing the I2C calls in ohci-nxp.c is waiting for the
phy framework so that I don't need to introduce new API in isp1301.c at
this point.

And right, in the ideal world, we have no I2C dependency and can control
a phy in an abstract way, even without depending on ISP1301, which could
be replaced by sth. else (not sure if this will be done/soldered
practically, though).

For now, will post patches for the current I2C dependency and the
PNX4008 removal.

Roland
