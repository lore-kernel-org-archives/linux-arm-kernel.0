From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 27 Jun 2011 19:57:17 +0530
Subject: [PATCH 1/4] davinci: psc.h: clean up indentation done using spaces
In-Reply-To: <201106251948.19834.arnd@arndb.de>
References: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F3E@dbde02.ent.ti.com>
	<201106251948.19834.arnd@arndb.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D7934B5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sat, Jun 25, 2011 at 23:18:19, Arnd Bergmann wrote:
> On Friday 24 June 2011, Nori, Sekhar wrote:
> > This series of 4 patches added SATA support on DaVinci
> > DA850 platform. This was ready for last merge window,
> > but was not queued because of the negative diffstat
> > rule.
> > 
> > Is there a possibility of queuing this for the v3.1 merge?
> > 
> > Here is the archive link of this posting:
> > 
> > http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-March/022473.html
> 
> My general idea is to have multiple branches per subarchitecture,
> and I started merging stuff into the tree now.
> 
> Your series contains both cleanups and support for additional
> features, and I'd like to see those split into separate branches.

Okay.

> 
> Please make sure the patches apply on top of 2.6.39 and resubmit
> them, separating out the first cleanup patch from the others.

Is it 2.6.39 or v3.0-rc? Linux-next is currently at v3.0-rc4.

I can create a branch with just the clean-up stuff and
another branch with the features (and its dependencies
from fixes/clean-up).

By "resubmit" I assume you are not asking for a re-send
of the patches to the mailing list (I can do that if you
want).

> We can definitely forward all cleanups and bug fixes in the each
> merge window. For new features, it mostly depends on how much
> code gets added that should not really be needed in a perfect
> world, relative to the amount of cleanups that is actually
> going into the platform in order to get there.

Okay.

> In case of the SATA support, the feature is relatively small
> and requires little board-specific code, which is good.
> However, if you are planning to push a lot of small additions
> like this, I would expect you spend much more effort on
> consolidation within davinci and migration towards device
> tree probing first.

I don't see new SoCs/boards getting added to the DaVinci
tree in the near term but there are some features of existing
platforms (like USB on DM365 or SATA on DA850) which are missing
in mainline for which there are patches being sent. 

To my knowledge, there isn't any ongoing work on moving DaVinci
to device tree. I am working on getting the low(er) hanging things
like GPIO movement to drivers/gpio done. DaVinci will eventually
move to device-tree, but may be not as soon as OMAP where
there is a lot more active work ongoing.

> What else do you have pending for davinci in 3.1? Can you
> send pull requests for cleanups/fixes/device-tree/features?

Actually not quite a lot at the moment, but there are some
patches which are waiting for acks/dependencies and some
pending re-work.

I will send a pull request with what has been reviewed and
accepted already.

I guess I also need to ask Stephen Rothwell to remove the
DaVinci next branch from the list of branches he is merging
for linux-next.

Thanks,
Sekhar
