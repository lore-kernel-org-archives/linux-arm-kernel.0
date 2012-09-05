From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Sep 2012 19:44:29 -0400
Subject: [GIT PULL] Kirkwood: board changes for v3.7
In-Reply-To: <20120905043435.GB6747@quad.lixom.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120905043435.GB6747@quad.lixom.net>
Message-ID: <20120905234429.GZ19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Thanks for the help!

On Tue, Sep 04, 2012 at 09:34:35PM -0700, Olof Johansson wrote:
> On Tue, Aug 28, 2012 at 08:11:29PM -0400, Jason Cooper wrote:
> > The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> > 
> >   Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7-v2
> 
> Hmm, this branch contains one duplicate patch due to me applying one
> straight to our fixes branch ("ARM: Kirkwood: Fix 'SZ_1M' undeclared here
> for db88f6281-bp-setup.c"). I also didn't see that mentioned in the pull
> request below, so I'm guessing you added it afterwards. There are also a
> couple of merge conflicts with other fixes we have already pulled in from
> you, it'd be nice if you just based this branch on those fixes instead.
> 
> Also, I wonder if I could have you split up this branch a bit more? My
> suggestions are below. You can have branches build on top of each other where
> there are dependencies, just please point them out when you send the pull
> requests.
> 
> 
> Let me know if I'm unclear or if there's something that doesn't make sense,
> I'll be happy to help.

No problem, but I do have one question.  Say I have two branches,

	fixes
	dt

And then a 'board' patch depends on stuff in both fixes and dt.  If I base
the board branch on fixes, do I 'git merge' the dt branch, 'git
cherry-pick' the dependency (what I did before), or something else I'm
not aware of?

I've avoided 'git merge' up till now because it creates a merge commit,
which feels wrong.  Perhaps I'm wrong here?

All the branch assignments look good, assuming I can figure out the
above question.

> > 
...
> >       arm: plat-orion: use 'void __iomem *' in addr-map code
> 
> Hmm, I would prefer if the actual constants were annotated instead of cast in
> the code here. See how we handled that on tegra with IOMEM(). That will also
> help sparse catch unannotated uses of those constants.
> 

I'll ask Thomas if he can redo this one.

thx,

Jason.
