From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Apr 2015 17:37:27 +0200
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <20150409172826.18916274@bbrezillon>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150409151846.GE1459@lunn.ch>
 <20150409172826.18916274@bbrezillon>
Message-ID: <20150409153727.GF1459@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 05:28:26PM +0200, Boris Brezillon wrote:
> Hi Andrew,
> 
> On Thu, 9 Apr 2015 17:18:46 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Thu, Apr 09, 2015 at 04:58:41PM +0200, Boris Brezillon wrote:
> > > Hello,
> > > 
> > > This is an attempt to replace the mv_cesa driver by a new one to address
> > > some limitations of the existing driver.
> > > >From a performance and CPU load point of view the most important
> > > limitation is the lack of DMA support, thus preventing us from chaining
> > > crypto operations.
> > > 
> > > I know we usually try to adapt existing drivers instead of replacing them
> > > by new ones, but after trying to refactor the mv_cesa driver I realized it
> > > would take longer than writing an new one from scratch.
> > 
> > Hi Boris
> > 
> > What is the situation with backwards compatibility? I see you have
> > kept the old compatibility string, and added lots of new ones, and
> > deprecated some properties. Will an old DT blob still work?
> 
> Yep, I tried on an Orion platform, and Arnaud tried on a Kirkwood one
> without any changes to the existing DT and it works.

Great. It would be nice to state this in the ChangeLog or cover note.

> Anyway, IMHO even those DT should be updated to use the new bindings
> (sram nodes, new compatible if available, addition of clock-names
> properties, ...).

Agreed. Maybe you can extend the patchset to modify the relevant .dtsi
files?

Thanks
	Andrew
