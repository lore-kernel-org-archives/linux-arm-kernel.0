From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Mar 2010 19:48:27 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <20100320004746.GB11448@atomide.com>
References: <20100320003605.GA11448@atomide.com>
	<20100320004746.GB11448@atomide.com>
Message-ID: <20100320024827.GC11448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100319 17:42]:
> * Tony Lindgren <tony@atomide.com> [100319 17:30]:
> > Hi all,
> > 
> > Got a zoom3 finally! This is needed to boot with DEBUG_LL + earlyprintk.
> 
> And of course it won't compile because of a missing #.
> Here's the working version.

One more time. Looks like what I posted is not enough, we
also need to make sure the mapping does not overlap with
other regions. So basically we can't use 0xfb000000 like
we currently have, let's use 0xf7000000 instead unless
somebody has better ideas.

Regards,

Tony
