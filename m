From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Jan 2013 19:01:09 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130131224457.GB17976@schnuecks.de>
References: <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
 <20130131224457.GB17976@schnuecks.de>
Message-ID: <20130201000109.GK7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 11:44:57PM +0100, Simon Baatz wrote:
> Hi Jason, Sebastian,
> 
> On Wed, Jan 30, 2013 at 06:01:00PM -0500, Jason Cooper wrote:
> > 
> > wrt to runit gating, the only case we are not covering is if of_serial
> > is a module (and so is everything else using the runit clk).  That's
> > *really* rare.  If someone embarks down that path, they get the
> > responsibility of not writing to all the deactivated registers. ;-)
> 
> With the serial driver now enabling runit it is really rare, but
> where is your enthusiasm to get to the bottom of it?

No one responded to my email.  I figured I got a little too intense and
decided to let it go.  Didn't want to be the ranting a-hole (too late). :-)

If you're interested, I still have a few ideas.  One was to wire two USB
serial adapters end to end to create a different console
(console=/dev/ttyUSB0,115200, getty, etc).  Since they would be going
over usb, that's a different clock, so it should work and provide us
with a safety net.

I'll see if I can dig up a few spare cables and try it out over the next
few days.  Priority is to get the pull requests for v3.9 in, though.

thx,

Jason.
