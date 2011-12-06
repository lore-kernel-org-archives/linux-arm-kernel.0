From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 23:16:30 +0000
Subject: [GIT PULL v2] Linux support for ARM LPAE
In-Reply-To: <CAHkRjk6ATr1thCL+-Cb4bOiObVmXrcoqvBiEBVzss_dATjt1VA@mail.gmail.com>
References: <20111206152955.GC31720@arm.com>
 <20111206203416.GV14542@n2100.arm.linux.org.uk>
 <CAHkRjk6ATr1thCL+-Cb4bOiObVmXrcoqvBiEBVzss_dATjt1VA@mail.gmail.com>
Message-ID: <20111206231630.GY14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 10:24:28PM +0000, Catalin Marinas wrote:
> On 6 December 2011 20:34, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Dec 06, 2011 at 03:29:55PM +0000, Catalin Marinas wrote:
> >> I updated the series with an additional signed-off-by to your patch. The
> >> code is unchanged. Could you please pull it again?
> >
> > I will for this time only, but note - last time you said:
> >
> >> If there are no further comments, could you please pull the ARM LPAE
> >> branch below? They should be merged after Will's idmap patches (no real
> >> conflict, just correctly functioning setup_mm_for_reboot).
> >
> > Now, the thing is, merging it after Will's patches won't solve that in
> > any shape or form - it really does not matter what order I do the merges
> > in, the fact of the matter is that there is no ordering or dependence
> > between your patches and Will's, so there's no guarantee that your code
> > will see a properly functioning setup_mm_for_reboot.
> 
> This situation is not unique to my LPAE patches (git bisect doesn't
> always go well merges).

We should _strive_ to make git bisect work where possible.  It's merge
windows where the most breakage happens, and if they're not bisectable
then that kills a valuable debugging tool.  With more and more thousands
of commits going in to each merge window, it's becoming increasingly
important that it works.

> But if you want, there other solutions:
> 
> 1. I can rebase the LPAE branch on top of your devel-stable _after_
> you merged Will's patches. Then I send another pull request.
> 
> 2. Only merge the LPAE patches without the one adding the Kconfig
> option. Later apply the Kconfig patch.
> 
> > If you actually depend on something in some other tree, you need to have
> > it merged into your tree _before_ the objects which depend on it.
> 
> Not easy in this instance. AFAIK Will's code relied on some reset
> patches from you, so Will just used your devel-stable branch.

I'll grant you that it hasn't been easy, because Will has had to rebase
his git tree at my request, because of the breakage of Samsung and OMAP
with Marc's irqchip-consolidation patches.

Nevertheless, we're at -rc3, which means there is no reason to rush this.
There is no problem with you waiting until Will's idmap patches have been
merged (they have) and then moving on from there.

> > As I said, I will merge it this time around, but next time I won't.
> 
> As I also said above, there are solutions. What it is really needed is
> _better_ collaboration during merges and _discussing_ the best
> approach rather than threatening that there won't be other pulls.

And what about the email from Philippe on me rejecting your first pull
request?  There is no need to try to exert commercial pressures when the
problems are legal and technical.
