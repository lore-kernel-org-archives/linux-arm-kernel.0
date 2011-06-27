From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Jun 2011 17:25:14 +0200
Subject: [PATCH 1/4] davinci: psc.h: clean up indentation done using spaces
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D7934B5@dbde02.ent.ti.com>
References: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
	<201106251948.19834.arnd@arndb.de>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7934B5@dbde02.ent.ti.com>
Message-ID: <201106271725.14310.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 June 2011, Nori, Sekhar wrote:
> On Sat, Jun 25, 2011 at 23:18:19, Arnd Bergmann wrote:
> > On Friday 24 June 2011, Nori, Sekhar wrote:
> > Please make sure the patches apply on top of 2.6.39 and resubmit
> > them, separating out the first cleanup patch from the others.
> 
> Is it 2.6.39 or v3.0-rc? Linux-next is currently at v3.0-rc4.

If there are no conflicts with 3.0-rc changes, submitting
based on the previous release (2.6.39) is ok, otherwise just
pick the most recent -rc release. Best avoid basing on top
of an arbitrary commit between two -rc though.

> I can create a branch with just the clean-up stuff and
> another branch with the features (and its dependencies
> from fixes/clean-up).
> 
> By "resubmit" I assume you are not asking for a re-send
> of the patches to the mailing list (I can do that if you
> want).

I'd prefer submission in form of a git-pull request in this
case, but sending to the mailing list is ok, too.

> > In case of the SATA support, the feature is relatively small
> > and requires little board-specific code, which is good.
> > However, if you are planning to push a lot of small additions
> > like this, I would expect you spend much more effort on
> > consolidation within davinci and migration towards device
> > tree probing first.
> 
> I don't see new SoCs/boards getting added to the DaVinci
> tree in the near term but there are some features of existing
> platforms (like USB on DM365 or SATA on DA850) which are missing
> in mainline for which there are patches being sent. 
> 
> To my knowledge, there isn't any ongoing work on moving DaVinci
> to device tree. I am working on getting the low(er) hanging things
> like GPIO movement to drivers/gpio done. DaVinci will eventually
> move to device-tree, but may be not as soon as OMAP where
> there is a lot more active work ongoing.

Yes, makes sense since you are working on both.

> > What else do you have pending for davinci in 3.1? Can you
> > send pull requests for cleanups/fixes/device-tree/features?
> 
> Actually not quite a lot at the moment, but there are some
> patches which are waiting for acks/dependencies and some
> pending re-work.
> 
> I will send a pull request with what has been reviewed and
> accepted already.

Ok. Do you also have a public tree with all the patches that
you would hope to get merged eventually? I'd just like to
get an impression of what's to come.

> I guess I also need to ask Stephen Rothwell to remove the
> DaVinci next branch from the list of branches he is merging
> for linux-next.

Yes, that would be good, but we might need to do that in a
more coordinated way for all the ARM platforms once they
are reasonably merged into my tree.

	Arnd
