From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 26 Dec 2011 21:44:41 +0100
Subject: [PATCH 1/2] PM / Domains: Add OF support
In-Reply-To: <20111226192424.GN8722@opensource.wolfsonmicro.com>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <201112262013.19995.rjw@sisk.pl>
 <20111226192424.GN8722@opensource.wolfsonmicro.com>
Message-ID: <201112262144.42211.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 26, 2011, Mark Brown wrote:
> On Mon, Dec 26, 2011 at 08:13:19PM +0100, Rafael J. Wysocki wrote:
> > On Monday, December 12, 2011, Thomas Abraham wrote:
> 
> > > A device node pointer is added to generic pm domain structure to associate
> > > the domain with a node in the device tree.
> 
> > That sounds fine except for one thing: PM domains are not devices, so adding
> > "device node" pointers to them is kind of confusing.  Perhaps there should be
> > something like struct dt_node, representing a more general device tree node?
> 
> There's struct of_node which is exactly that, though practically
> speaking you need a device if you're going to bind automatically to
> something from the device tree in a sensible fashion and there is actual
> hardware under there so a device does make some sense.
> 
> This is in part compatibility with the existing Exynos code which uses
> devices to probe the domains for non-DT systems.

Well, that's not a general case, though.

It doesn't feel approporiate to use a "device node" pointer for something
that's not based on struct device, at least not a generic level, so I wonder
if there's a different way.

Thanks,
Rafael
