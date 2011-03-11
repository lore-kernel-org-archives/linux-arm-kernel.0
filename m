From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Mar 2011 00:09:28 +0000
Subject: [PATCH 3/8] macb: convert printk to pr_ and friends
In-Reply-To: <1299797284.20104.162.camel@Joe-Laptop>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-4-git-send-email-jamie@jamieiles.com>
	<1299797284.20104.162.camel@Joe-Laptop>
Message-ID: <20110311000928.GI6198@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 02:48:04PM -0800, Joe Perches wrote:
> On Thu, 2011-03-10 at 10:10 +0000, Jamie Iles wrote:
> > macb is already using the dev_dbg() and friends helpers so use pr_foo()
> > along with a pr_fmt() definition to make the printing a little cleaner.
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Hi Jamie.
> 
> Because these conversions use a struct net_device,
> they would be better as:
> 
> 	netdev_<foo>(struct net_device *dev, const char *fmt, ...)

Ahh nice, I hadn't come across those before.  I'll update all of the 
pr_* and dev_* statements to use the netdev variants.

Thanks for that!

Jamie
