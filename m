From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 14:41:51 +0100
Subject: memblock_is_region_reserved() issue
In-Reply-To: <1280894327.1902.138.camel@pasglop>
References: <1280882307.1902.124.camel@pasglop>
	<1280885890.1902.134.camel@pasglop>
	<1280894327.1902.138.camel@pasglop>
Message-ID: <20100902134151.GK26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 04, 2010 at 01:58:47PM +1000, Benjamin Herrenschmidt wrote:
> Hi folks !
> 
> You seem to use memblock_is_region_reserved() in a few places in the new
> code assuming (as I would) that it returns a boolean (0 reserved, !0 not
> reserved).

That's where having a comment describing such things would be useful,
so that it's easier to ensure that it's correct at creation/review time.

> However, the implementation looks totally wrong. I was wondering if you
> had noticed :-)

I guess not - I relied on others to test that code... no reports were
forthcoming of breakage.  Maybe the test cases didn't involve paths
through this code though.
