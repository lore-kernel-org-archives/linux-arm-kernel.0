From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 09:21:02 -0400
Subject: [GIT PULL V3 2/5] ARM: Kirkwood: DT changes for v3.7
In-Reply-To: <20120922051158.GA32245@quad.lixom.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921194629.GW5469@titan.lakedaemon.net>
 <20120922051158.GA32245@quad.lixom.net>
Message-ID: <20120922132102.GC5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:11:58PM -0700, Olof Johansson wrote:
> Hi Jason,
> 
> On Fri, Sep 21, 2012 at 03:46:29PM -0400, Jason Cooper wrote:
> > The following changes since commit 5b40baee4a39d96d4d6a48a2b2383982912c429b:
> > 
> >   arm: mvebu: add address decoding controller to the DT (2012-09-21 18:05:29 +0000)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/jcooper/linux.git kirkwood/dt
> 
> Looking at this branch, it's much more than just device tree updates.

Ok, my thinking was they (pinctrl and gpio) were devicetree-only
drivers, see below.

> It introduces the pinctrl driver (and bindings), and the gpio driver (and
> bindings). I think it would make more sense to break those two out to separate
> topics, and keep the generic DT updates in this branch.
> 
> Also, see my comment on the EHCI binding patch. I wasn't going to ask you to
> respin the branch to fix/drop that on its own, but if you do rebuild and split
> this branch up you might as well delay those patches until the binding has been
> fixed.

Ok.  I'll split out pinctrl and gpio into a kirkwood/drivers, leave the
rest in /dt, and drop the ehci changes.  /drivers will still depend on
/addr_decode, once you, Arnd, and Thomas work that out.  /dt should have
no deps then.

/cleanup will now depend only on /boards if we're dropping ehci for now.
/defconfig will still only depend on /boards.
/platform_data will still depend on everything kirkwood/*.

So, I take it /boards is ok?

> I'll pull in your branches under staging/* for now so they can get linux-next
> coverage until the "real" branches come in.

Okay, thanks.

thx,

Jason.
