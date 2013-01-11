From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 11 Jan 2013 06:59:08 -0500
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <20130111091349.55ee0e77@skate>
References: <20121211065813.GA14843@obsidianresearch.com>
 <20121211071333.GR17242@lunn.ch>
 <20121211185535.GA14534@obsidianresearch.com>
 <20130110014734.GC5075@titan.lakedaemon.net>
 <20130110060710.GM24650@lunn.ch> <50EE8FC5.50105@gmail.com>
 <20130110184832.GB28004@obsidianresearch.com>
 <20130110185737.GO5075@titan.lakedaemon.net>
 <20130111040219.GA23206@obsidianresearch.com>
 <20130111091349.55ee0e77@skate>
Message-ID: <20130111115908.GQ5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 09:13:49AM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Thu, 10 Jan 2013 21:02:19 -0700, Jason Gunthorpe wrote:
> 
> > I've attached the main mv dt patch as a MIME, sorry for the
> > awkwardness, I am travelling and won't be available... Please feel
> > free to re-post/alter as necessary. As I said before, I'm not happy
> > with it because it doesn't follow the standard convention for MDIO
> > phys.
> 
> The MDIO registers for the mv643xx_eth hardware are the same as the
> ones for the mvneta hardware. Therefore, I've splitted this into the
> mvmdio driver (available in mainline since 3.8,
> drivers/net/ethernet/marvell). This allows to have a nicely separated
> driver for the MDIO interface.
> 
> My plan was ultimately to modify the mv643xx_eth driver to use the
> mvmdio driver, and then do a nice DT binding on top of that.
> 
> Does this sounds like a good plan?

I like it.  If you haven't already, please review the thread at

http://www.spinics.net/lists/arm-kernel/msg186742.html

to see some of the concerns already raised.

thx,

Jason.
