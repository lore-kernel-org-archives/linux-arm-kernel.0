From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 24 Sep 2011 22:10:08 -0600
Subject: [PATCH v2 0/7] Add a generic struct clk
In-Reply-To: <1316730422-20027-1-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
Message-ID: <20110925041008.GQ24631@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:26:55PM -0700, Mike Turquette wrote:
> Hi all,
> 
> The goal of this series is to provide a cross-platform clock framework
> that platforms can use to model their clock trees and perform common
> operations on them.  Currently everyone re-invents their own clock tree
> inside platform code which makes it impossible for drivers to use the
> clock APIs safely across many platforms and for distro's to compile
> multi-platform kernels which all redefine struct clk and its operations.
> 
> This is the second version of the common clock patches which were
> originally posted by Jeremy Kerr and then re-posted with some additional
> patches by Mark Brown.  Mark's re-post didn't have any changes done to
> the original four patches from Jeremy which is why this series is "v2".
> 
> The changes in this series are minimal: I've folded in some of Mark's
> fixes and most of the comments posted to his series as well as rebasing
> on top of v3.1-rc7.  The design and functionality hasn't changed much
> since Jeremy posted v1 of this series.  Propagating the rate change up
> to the parent has been removed from clk_set_rate since that needs some
> more thought.  I also dropped Mark's change to append a device's name to
> a clk name since device tree might solve this neatly.  Again more
> discussion around that would be good.
> 
> v1 of the series can be found at,
> http://article.gmane.org/gmane.linux.kernel/1143182
> 
> Mark's re-post (v1+) can be found at,
> http://article.gmane.org/gmane.linux.ports.arm.kernel/129889

Looks good at first review to me.  I had a few comments, but nothing
major.  It really needs some documentation though.

g.
