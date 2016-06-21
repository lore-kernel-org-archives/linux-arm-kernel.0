From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 03:57:20 -0700
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <20160621103810.GI22406@atomide.com>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
Message-ID: <20160621105720.GK22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160621 03:41]:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [160621 02:50]:
> > 
> > There isn't really an answer which will always work for this problem,
> > as I've already detailed in a previous thread discussing the issue.
> > Adding a zImage header don't fix the problem.
> 
> Well how about we change both comments and code to use a value
> that works?

Maybe zImage size + MAX_RODATA_SZ + 4x zImage size?

Then the MAX_RODATA_SZ could be 2 or 4 MB or whatever we
think is sufficient to kick the can until we have a better
solution.

Regards,

Tony
