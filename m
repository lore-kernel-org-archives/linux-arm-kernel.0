From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2016 22:18:18 +0000
Subject: [PATCH] clk: gpio: Really allow an optional clock= DT property
In-Reply-To: <20160224214706.2278.79643@quark.deferred.io>
References: <20160219030731.GS4847@codeaurora.org>
 <1455851525-18972-1-git-send-email-sboyd@codeaurora.org>
 <20160223113059.GH19428@n2100.arm.linux.org.uk>
 <20160224214706.2278.79643@quark.deferred.io>
Message-ID: <20160224221818.GO19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 01:47:06PM -0800, Michael Turquette wrote:
> Hi Russell,
> 
> Quoting Russell King - ARM Linux (2016-02-23 03:30:59)
> > On Thu, Feb 18, 2016 at 07:12:05PM -0800, Stephen Boyd wrote:
> > > We mis-merged the original patch from Russell here and so the
> > > patch went almost all the way, except that we still failed to
> > > probe when there wasn't a clocks property in the DT node. Allow
> > > that case by making a negative value from
> > > of_clk_get_parent_count() into "no parents", like the original
> > > patch did.
> > 
> > So you apply it anyway, and ignore all further discussion.  I've
> > no idea what kind of politics is going on here, but it has to stop.
> 
> Stephen fixed the bug, and I didn't ask you to test because you made it
> clear that you did not have the time (understandable). Stephen
> reproduced the issue locally and insured that his version of the fix
> does actually fix it.

Right, so let's go back shall we.

The reason this bug happened is because you changed fully tested code
as a result of a merge conflict.  The result was not tested.

Now, rather than going back to the tested patch, you maintainers decide
to create yet another change, which is also untested and merge it
immediately into mainline.

That's really insane - you had a choice to do the sane thing: you could
have gone back and looked at my patch, realised that my patch resolves
the same problem that the conflicting patch did, and therefore the
correct resolution would be to make the code look the same after both
patches have been applied, as if it would have done if only my patch
had been applied.

And the resulting code would have been tested by implication of the
fact that the original code plus my patch was what I tested here.

But no, you guys think it's better to create some other solution to the
fuck up.

> He is an equal co-maintainer so of course I support him to merge the
> fix, plus I find his version more readable.

I really detest this maintainer shite - it seems anyone can walk up and
take 

> > I'm also still waiting for that apology from Mike - never apply a
> 
> No thematics please. When you wrongly accused me of merging code outside
> of the merge window[0] did I ask for an apology?
> 
> > modified patch without stating in the commit log that it was modified.
> > It's basically fraud.
> 
> An oversight for which we are both equally guilty.

Sorry, I disagree.  I'm not guilty of doing that, because when I apply
patches, they come straight from the patch system and are applied to
my tree unmodified.  There's no intermediate modification step possible.
Any changes I want to make are done in a separate commit.

So that's another apology you now owe me.

> The "change" was the
> resolution of a merge conflict, and I posted the resolved version of the
> patch to the thread[0]. You said, "Looks fine, thanks."

Yes, it _looked_ fine for a quick read, and I didn't test it.  I
trusted you to be competent at merge resolution, but I now see that
trust was misplaced.  I'll try to remember to pay more attention to
any changes you make in the future - or I'll merge them through my
tree.

Trust is something I initially give without earning - break that
trust and you've got to work really hard to regain it.

I'll also remind you that _I_ used to look after the clk code, until
you walked onto the scene and effectively took it away from me - I
didn't say a word about that (or all the other stuff that Linaro
"took" from me without asking.)  So you won't mind if I do a bit of
that myself by merging my own fixes through my tree.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
