From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Dec 2013 00:11:01 -0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20131205071224.GA8936@shlinux2.ap.freescale.net>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com>
 <1386082273.18201.61.camel@shinybook.infradead.org>
 <20131204184405.GE9468@ld-irv-0074.broadcom.com>
 <20131205071224.GA8936@shlinux2.ap.freescale.net>
Message-ID: <20131205081101.GA4636@norris.computersforpeace.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 03:12:25PM +0800, Huang Shijie wrote:
> On Wed, Dec 04, 2013 at 10:44:05AM -0800, Brian Norris wrote:
> > 
> > I mostly bring this up, though, because it is an example of hardware
> > that
> > 
> >    (a) can operate as a true SPI device (hardware (1) can handle generic
> >        SPI transfers), but
> >    (b) requires knowledge of the details of SPI flash in order to get
> >        optimal usage out of the acceleration from (2).
> > 
> > In my book, point (a) and (b) hold some bearing over the question of
> > "where should this SPI NOR framework live", because it is reasonable
> > that a single driver for this hardware should be able to handle either
> > true SPI devices or accelerated SPI-NOR flash.
> 
> We have add a @read_id hook for the spi-nor layer, you can use it to read out
> more info (such as the Device Geometry Definition) for your spi-nor controller driver.
> 
> Is it okay?

I'm not sure which @read_id hook you're talking about, as I've only
skimmed the most recent thread, and it's not in the last patch series I
have from you, I don't think. But that is not a response at all to the
points I brought up. My statements have nothing to do with device
geometry detection.

What I was actually addressing:

Your framework aligns with Mark's original suggestion: that the "SPI
NOR" framework should be a separate layer held entirely within the MTD
subsystem, and that any given driver is *either* a "SPI NOR" driver *or*
a "true SPI" driver, not both.

I'm simply describing how my hardware is both, and perhaps (as David
seems to be doing) we should reconsider the premise that this framework
will exist solely and entirely within MTD.

Brian
