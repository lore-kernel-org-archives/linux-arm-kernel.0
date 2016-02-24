From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 24 Feb 2016 13:47:06 -0800
Subject: [PATCH] clk: gpio: Really allow an optional clock= DT property
In-Reply-To: <20160223113059.GH19428@n2100.arm.linux.org.uk>
References: <20160219030731.GS4847@codeaurora.org>
 <1455851525-18972-1-git-send-email-sboyd@codeaurora.org>
 <20160223113059.GH19428@n2100.arm.linux.org.uk>
Message-ID: <20160224214706.2278.79643@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Quoting Russell King - ARM Linux (2016-02-23 03:30:59)
> On Thu, Feb 18, 2016 at 07:12:05PM -0800, Stephen Boyd wrote:
> > We mis-merged the original patch from Russell here and so the
> > patch went almost all the way, except that we still failed to
> > probe when there wasn't a clocks property in the DT node. Allow
> > that case by making a negative value from
> > of_clk_get_parent_count() into "no parents", like the original
> > patch did.
> 
> So you apply it anyway, and ignore all further discussion.  I've
> no idea what kind of politics is going on here, but it has to stop.

Stephen fixed the bug, and I didn't ask you to test because you made it
clear that you did not have the time (understandable). Stephen
reproduced the issue locally and insured that his version of the fix
does actually fix it.

He is an equal co-maintainer so of course I support him to merge the
fix, plus I find his version more readable.

> 
> I'm also still waiting for that apology from Mike - never apply a

No thematics please. When you wrongly accused me of merging code outside
of the merge window[0] did I ask for an apology?

> modified patch without stating in the commit log that it was modified.
> It's basically fraud.

An oversight for which we are both equally guilty. The "change" was the
resolution of a merge conflict, and I posted the resolved version of the
patch to the thread[0]. You said, "Looks fine, thanks."

In summary: bugs happen. Let's please just move on and get back to work.

[0] http://lkml.kernel.org/r/<20160103105319.GB5779@n2100.arm.linux.org.uk>

Regards,
Mike

> 
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
