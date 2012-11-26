From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Nov 2012 11:35:06 +0100
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <201211261028.26334.arnd@arndb.de>
References: <pull-1353733874-990435> <20121126091652.GA13866@quad.lixom.net>
 <20121126102805.5337f7f5@skate> <201211261028.26334.arnd@arndb.de>
Message-ID: <20121126113506.06c431cd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Mon, 26 Nov 2012 10:28:26 +0000, Arnd Bergmann wrote:
> On Monday 26 November 2012, Thomas Petazzoni wrote:
> > Right. The problem is that some of the last developments had many
> > dependencies against the previous developments, from various branches.
> > So I wasn't sure how to do this last developments, and I did merge the
> > branches containing the previous developments that I needed.
> > 
> > I am really open to suggestions on how to improve my Git workflow to
> > handle this better. It certainly wasn't my intention to have this
> > "test-the-merge" thing appear publicly.
> 
> One thing that Sascha Hauer first introduced was an extra branch that
> has everything merged together to show how you want to handle
> the conflicts. We'll then merge the individual branches and in the
> end can check if there is any difference to what you had.

Maybe I don't understand correctly, but the problem that I had is not a
problem of conflicts, but rather the need to do development *on top* of
branches for which pull requests had already been sent.

For example, the clk support in the network driver depended on:
 * The branch containing the new network driver to be there
 * The branch containing the mvebu clk infrastructure to be there

What should I have done to do this clk support in the network driver,
if not a merge of the network driver branch + the mvebu clk
infrastructure branch?

Again, I'm really still learning how to adjust my Git workflow to
handle those things properly. We had a good amount of changes for this
cycle, and I admit it has been quite messy on my end as I didn't really
know how to do things nicely.

Note that I am also surprised by the fact that we had to remove a
'clocks=' property in dove.dtsi, and therefore have a known-broken
3.8-rc1 even before it is released. It sounds strange to me that the
separation of branches prevents from doing the correct changes. But
maybe I'm not seeing the entire problem, and therefore under-estimating
the issues at hand.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
