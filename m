From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Sep 2014 23:49:30 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <20140904192943.11368.83896@quantum>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <3966110.RPrxdc8FBm@wuerfel> <20140904192943.11368.83896@quantum>
Message-ID: <201409042349.31210.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014, Mike Turquette wrote:
> Quoting Arnd Bergmann (2014-09-03 12:33:31)
> > On Wednesday 03 September 2014 11:49:56 Mike Turquette wrote:
> > > > Right, makes sense. We have in the past done it either way for other
> > > > platforms. When merging the patches through the clk subsystem, it still
> > > > makes sense to let us know of those plans and ask for an Ack from
> > > > the arm-soc maintainers, to be sure we can plan ahead in case there
> > > > are other (conflicting) patch sets that are sent through arm-soc.
> > > 
> > > Do I have your Ack for the arch/arm patches?
> > > 
> > > [0] https://lkml.kernel.org/r/<1409758148-20104-1-git-send-email-tomeu.vizoso@collabora.com>
> > 
> > I have no objection to the change, but we might need to be careful in
> > case we get a lot of conflicts.
> > 
> > How about making it a shared branch that you plan to send upstream
> > but that we can also include in arm-soc to avoid conflicts if necessary?
> 
> Sounds good. I'll probably need to perform a bit of surgery on my tree
> and rebase it in order to have the minimum set of patches that get
> pulled into arm-soc.

Ok, I see. We might not pull it in right away, because it's possible that there
are no actual conflicts and we don't need them, but it's definitely good
if your branch is ready in case we do.

	Arnd
