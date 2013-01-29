From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 09:08:55 +0800
Subject: [GIT PULL] imx cleanup for 3.9
In-Reply-To: <20130128220026.GC3047@quad.lixom.net>
References: <20130122144813.GD2812@S2101-09.ap.freescale.net>
 <20130128220026.GC3047@quad.lixom.net>
Message-ID: <20130129010853.GA24352@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 02:00:26PM -0800, Olof Johansson wrote:
> Hi,
> 
> On Tue, Jan 22, 2013 at 10:48:15PM +0800, Shawn Guo wrote:
> 
> > Shawn Guo (4):
> >       ARM: dts: imx: use nodes label in board dts
> 
> Hmm.
> 
> This patch is 1000 lines of pure churn. Sure, the style on OMAP is different,
> but there's no clear benefit from it -- it's actually advantageous to see some
> of the bus hierarchies even on the leaf-level board nodes.
> 
> Would you mind respinning with this left out, please? If you still want to
> argue it to be included, we can do so, but I'd like to pick up the rest of the
> branch meanwhile. :-)

I will refresh the pull-request to leave it out, but meanwhile I'd like
to argue too, as the approach has been agreed by IMX people and all the
patches I queued on imx/dt are all in this way.  And I will move the
patch to imx/dt branch instead, if you're not strongly against the
approach.

The board level dts are mostly used to add/overwrite properties for
nodes defined in soc dts.  Therefore, what people who look at board
dts care about is those properties, not really which bus the nodes
are on.  We go this way to have board dts focus on the things they
are created for.  It's much easer to read and edit those properties.

I'm not sure why it's important to maintain the bus topology in board
dts while we have the full one in soc dts.  In the current way, people
sometimes have to reassemble 3 or more levels bus hierarchies for only
overwriting one property for one node.  

I'm pretty sure that people who work on board level dts would vote for
this way.  It makes their life easier without increasing the
maintainer's burden.  So why not?

Shawn
