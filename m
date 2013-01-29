From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 06:18:57 -0800
Subject: [GIT PULL] imx cleanup for 3.9
In-Reply-To: <20130129072603.GL1906@pengutronix.de>
References: <20130122144813.GD2812@S2101-09.ap.freescale.net>
 <20130128220026.GC3047@quad.lixom.net>
 <20130129010853.GA24352@S2101-09.ap.freescale.net>
 <20130129072603.GL1906@pengutronix.de>
Message-ID: <20130129141857.GA12723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 08:26:03AM +0100, Sascha Hauer wrote:
> On Tue, Jan 29, 2013 at 09:08:55AM +0800, Shawn Guo wrote:
> > On Mon, Jan 28, 2013 at 02:00:26PM -0800, Olof Johansson wrote:
> > > Hi,
> > > 
> > > On Tue, Jan 22, 2013 at 10:48:15PM +0800, Shawn Guo wrote:
> > > 
> > > > Shawn Guo (4):
> > > >       ARM: dts: imx: use nodes label in board dts
> > > 
> > > Hmm.
> > > 
> > > This patch is 1000 lines of pure churn. Sure, the style on OMAP is different,
> > > but there's no clear benefit from it -- it's actually advantageous to see some
> > > of the bus hierarchies even on the leaf-level board nodes.
> > > 
> > > Would you mind respinning with this left out, please? If you still want to
> > > argue it to be included, we can do so, but I'd like to pick up the rest of the
> > > branch meanwhile. :-)
> > 
> > I will refresh the pull-request to leave it out, but meanwhile I'd like
> > to argue too, as the approach has been agreed by IMX people and all the
> > patches I queued on imx/dt are all in this way.  And I will move the
> > patch to imx/dt branch instead, if you're not strongly against the
> > approach.
> > 
> > The board level dts are mostly used to add/overwrite properties for
> > nodes defined in soc dts.  Therefore, what people who look at board
> > dts care about is those properties, not really which bus the nodes
> > are on.  We go this way to have board dts focus on the things they
> > are created for.  It's much easer to read and edit those properties.
> > 
> > I'm not sure why it's important to maintain the bus topology in board
> > dts while we have the full one in soc dts.  In the current way, people
> > sometimes have to reassemble 3 or more levels bus hierarchies for only
> > overwriting one property for one node.  
> > 
> > I'm pretty sure that people who work on board level dts would vote for
> > this way.  It makes their life easier without increasing the
> > maintainer's burden.  So why not?
> 
> I'm with Shawn here. With this board layout I'm now able to write board
> dts files without looking much at the dtsi file at all. It's debatable
> if existing boards have to be changed to use this layout, but since
> people copy-paste all the time changing it increases the chance they
> copy the right stuff.

Ok. Just to make clear: While I personally prefer the regular way of specifying
the board dts files, my main concern with this patch is that it is _pure
churn_. It's 1000 lines of change without a functional benefit, and without
really being a cleanup that benefits long-term development.

We're starting to get more comments about the volume of churn again (Linus made
a couple of them the last merge window), and I'd rather be a bit more
conservative on some of the larger changes that lack strong benefit for
a release or two, than have him get ticked off and make life miserable for all
of us.

So, I'm not saying that it's a bad idea to change to labels, but I would rather
hold off this while we give some of the remaining platforms still not
multiplatform-enabled a chance to "use the churn quota" since they will need it
for include file moves, etc, etc.


-Olof
