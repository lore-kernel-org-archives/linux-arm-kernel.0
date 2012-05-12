From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 12 May 2012 21:58:13 +0200
Subject: [GIT PULL] Renesas ARM-based platforms updates for v3.5
In-Reply-To: <CAOesGMgFWM6K6969Oz6xGewrRekyrJA-ztGBADxsqnB1w=V2QA@mail.gmail.com>
References: <201205112101.59949.rjw@sisk.pl>
 <CAOesGMgFWM6K6969Oz6xGewrRekyrJA-ztGBADxsqnB1w=V2QA@mail.gmail.com>
Message-ID: <201205122158.13999.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 12, 2012, Olof Johansson wrote:
> On Fri, May 11, 2012 at 12:01 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
> >
> >    Linux 3.4-rc6
> >
> > with top-most commit 5658c94096c16e769203b6dea5e5f04e7ff12633
> >
> >    Merge branch 'renesas-kzm9g' into renesas-soc-new
> >
> > from the git repository at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-new
> >
> > to receive new Renesas ARM-based platforms material for v3.5.  Included are:
> >
> >  * Urgent regression and SMP fixes (also included in the fixes branch that I've
> >   just sent a separate pull request for in the hope it is still possible to
> >   push them for v3.4).  Two of those fixes are duplicated in the renesas-sh7372
> >   branch, which is because I learned that they were fixes for recent
> >   regressions after they had gone to that branch.  Sorry about that.
> >
> >  * Updates for boards based on the sh7372 and r8a7740 SoCs.
> >
> >  * Support for 2 new boards, armadillo800eva and KZM-A9-GT.
> 
> Hi Rafael,
> 
> If you take a look at how the other ARM subarch maintainers organize
> the patches that they feed up to us, you'll see that they group them
> either per functional topic, or more commonly per subject such as
> "core soc updates", "soc driver updates", "board updates", "device
> tree updates", "cleanup", and so on.
> 
> That fits the model we've been having on arm-soc as well, since we
> split our tree up per category like that, and send those cross-section
> branches between different vendors (but same categories) up to Linus
> that way.
> 
> 
> So, would you mind taking a look at what you have in the new-soc
> branch and reshuffling things a bit? Looking at the history of the
> new-soc branch and the rest of the repo, it seems that you're already
> more or less organizing your tree the way I am asking for, it's just
> that you merged them all together before sending this pull request.

Well.

I'd prefer not to rebase any branches and move commits around if that's
what you're talking about, because I have a rule that my branches are not
rebased, except for the next one.

Now, there are three categories of commits in the soc-new branch,
"core soc updates", "board updates" and "new board support".  However,
"board updates" depend on "core soc updates" and go together with them
in two branches, "sh7372" and "r8a7740" (branch names are after SoC names
and each branch contains updates for the given SoC and boards based on it).
I can send a pull request to you separately for each of those branches,
if you prefer, or I can merge them together and send a pull request for
the whole (it actually is a separate branch in my tree, called "soc").

The new board support stuff is just that - commits adding support for
new boards.  Those things, however, depend on the "core soc updates" and
"board updates", so they are based on the "soc" branch (honestly, I don't
think they will work without the "core" changes).  So, while I could
send separate pull requests for the "armadillo800eva" and "kzm9g" branches,
I don't think that merging them without the changes in the "soc" branch will
do any good.

Thanks,
Rafael
