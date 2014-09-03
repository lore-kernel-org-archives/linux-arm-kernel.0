From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 20:31:44 +0200
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <20140903163130.GM3127@leverpostej>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <2843702.jP4KCB2Kid@wuerfel> <20140903163130.GM3127@leverpostej>
Message-ID: <6499926.sQm3J8L764@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 17:31:30 Mark Rutland wrote:
> 
> However, I'm not sure I follow the reasoning for making this
> significantly harder, and even ignoring that I don't think this does
> make things significantly harder. Especially so if we have a PSCI node
> but not an enable method -- in that case its trivial to patch in an
> unrelated enable-method anyhow.

Right, it's not actually much harder. A better way to look at it is
probably that we document what which parts we expect to stay constant
and which parts are to be filled out by the boot loader. Independent
of what PSCI implementation the boot loader provides, we would like
to see enable-method="psci".

I just saw that Geoff had a related comment, and documenting this
would make it clearer to other reviewers, as well as people that
happen to look at this file as a base for new platforms.

	Arnd
