From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 21 Sep 2012 15:39:15 -0700
Subject: [V4 3/4] power_supply: Enable battery-charger for 88pm860x
In-Reply-To: <20120921221422.GA28670@sortiz-mobl>
References: <20120714081254.GD20018@lizard>
 <1343377636-16128-1-git-send-email-jtzhou@marvell.com>
 <20120823034815.GB16674@lizard> <20120823044348.GA415@lizard>
 <CACDDiy-ZzUxi4MvjELwHzYC+AxF0b0+LuOh=JdFBBgSA2ijjNw@mail.gmail.com>
 <20120823122239.GA29485@lizard>
 <CAN1soZy-O2DGH89QwhBOiR=1+cv81t779EwwcYevU68bLkMdfQ@mail.gmail.com>
 <20120920223505.GA29721@lizard>
 <20120921221422.GA28670@sortiz-mobl>
Message-ID: <20120921223913.GA25603@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 12:14:22AM +0200, Samuel Ortiz wrote:
> > > >> Thanks for helping me to amend these patch.  I got many good
> > > >> suggestions and learn a lot in this process:) BTW, you mean you will
> > > >> help to amend that several minor warning with battery tree?
> > > >
> > > > Yup, I have these small fixups locally in my tree already, so if/once
> > > > Samuel gives me an Ack for the mfd part, I'll merge it into battery git
> > > > tree.
> > > 
> > > Any updates?
> > 
> > OK, I guess I can just go ahead and apply it, the MFD changes are very
> > trivial anyway. So, this is now applied (along with some fixups that
> > I was talking about in my previous reply).
> Applying this patch as is will not build as the mfd_add_devices() API has
> changed. Either you rebase your patchset on top of Linus tree or I take this
> patch and fix the mfd_add_devices() call. Please let me know how you want to
> proceed.

It's not the first time this happens, and git let us fix it in a pretty
elegant way: what I'm usually doing is just pulling Linus' tree back into
my tree (but not rebasing), and in the merge commit I fixup the issue.
That way things are still bisectable, and everything should work before
and after mfd_add_devices() change.

So, it's all OK, I'll just merge Linus' -rc6 back into my tree
(and Stephen already has a fix in linux-next).

Thanks!
Anton.
