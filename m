From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Feb 2011 18:39:05 -0700 (MST)
Subject: [PATCH] OMAP2/3: PM: remove unnecessary wakeup/sleep dependency
	clear
In-Reply-To: <alpine.DEB.2.00.1102101617200.21991@utopia.booyaka.com>
References: <alpine.DEB.2.00.1101270252010.16671@utopia.booyaka.com>
	<871v3yp5km.fsf@ti.com> <871v3ffps6.fsf@ti.com>
	<alpine.DEB.2.00.1102101617200.21991@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1102101836530.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Feb 2011, Paul Walmsley wrote:

> On Thu, 10 Feb 2011, Kevin Hilman wrote:
> 
> > While testing, I found out this patch breaks suspend/resume and idle on
> > at least 34xx.
> > 
> > A first suspend/resume works fine, but on subsequent ones SGX
> > powerdomain does not hit retention (and thus CORE powerdomain does not
> > either....
> 
> ...
> 
> > Simply adding back the above 5 lines (the SGX ones) gets things working
> > again, which suggests something isn't quite right with SGX, but I
> > haven't found the exact reason yet.
> 
> Thanks for the report, I will take a look.

Kevin and I did some debugging on this.  It turns out that there is a bug 
in the recent clockdomain abstraction code in the git.pwsan.com 
integration branch that caused the underlying problem.  Will follow up 
with comments on the threads of the original patches.

Kevin is planning to keep the patch under discussion in this thread in 
his 2.6.39 queue...


- Paul
