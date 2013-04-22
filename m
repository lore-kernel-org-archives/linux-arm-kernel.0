From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 22 Apr 2013 18:54:56 -0400
Subject: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
In-Reply-To: <20130422214543.GJ29947@lunn.ch>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
 <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
 <87wqrutjss.fsf@octavius.laptop.org>
 <20130422203723.GI29947@lunn.ch>
 <20130422210949.GJ25724@titan.lakedaemon.net>
 <20130422214543.GJ29947@lunn.ch>
Message-ID: <20130422225456.GK25724@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:45:43PM +0200, Andrew Lunn wrote:
> > > > The core function mmc_of_parse() (new in 3.9) will do all of this DT
> > > > parsing for you, and will also take care of the driver's later calls
> > > > to mmc_gpio_request_{cd,wp}().  Could you try using that function
> > > > instead, please?
> > > 
> > > Hi Chris, Simon
> > > 
> > > I have a vague recollection that Thomas Petazzoni already did this
> > > conversion. Take a look in linux-next, or maybe Jason can point you at
> > > a branch.
> > 
> > Andrew,
> > 
> > Thomas did a board conversion here (slated for v3.11 in /pcie branch):
> > 
> >   cd2bde5 arm: kirkwood: convert db-88f6281 to the Device Tree
> > 
> > And Sebastian did some mvsdio WP and CD pin work here:
> > 
> >   0d0644eARM: Kirkwood: fix unused mvsdio gpio pins
> > 
> > Nothing else really jumps out though.  Where either of these what you
> > were thinking of?
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138514.html
> 
> and
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138513.html

Ahh, they were with the original submission for mvsdio:

  07728b7 mmc: mvsdio: use slot-gpio for card detect gpio
  3724482 mmc: mvsdio: use slot-gpio infrastructure for write protect gpio

I thought you were referring to a newer patch.

thx,

Jason.
