From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 11 Sep 2018 09:53:21 +0800
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180910151926.GA10889@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk>
 <20180909020021.GA18838@dragon>
 <20180910151926.GA10889@sirena.org.uk>
Message-ID: <20180911015320.GA25790@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 04:19:26PM +0100, Mark Brown wrote:
> On Sun, Sep 09, 2018 at 10:00:23AM +0800, Shawn Guo wrote:
> > On Thu, Sep 06, 2018 at 11:15:17AM +0100, Mark Brown wrote:
> 
> > > I was expecting to get a pull request with the precursor patches in it -
> > > the regulator driver seems to get a moderate amount of development so
> > > there's a reasonable risk of conflicts.
> 
> > What about you create a stable topic branch for regulator patches and I
> > pull it into IMX tree?
> 
> Sure, I can send a pull request back but the first two patches in the
> series are ARM ones - are you OK with me just applying them and sending
> them in the pull request or do you want to apply them first?

I just took another look at the series.  It seems that there is no
build-time dependency between regulator and platform patches.  So I
think we can handle the series like:

 - You apply patch #3, #4 and #5 on regulator tree;
 - I apply the reset on IMX tree.

There shouldn't be any build or run time regression on either tree, and
the feature that the series adds will be available when both trees get
merged together on -next or Linus tree.

@Oleksij Is my understanding above correct?

Shawn
