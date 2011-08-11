From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 11 Aug 2011 10:01:47 +0100
Subject: [PATCHv3 4/9] macb: convert printk to netdev_ and friends
In-Reply-To: <1312921227.11924.35.camel@Joe-Laptop>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-5-git-send-email-jamie@jamieiles.com>
	<1312921227.11924.35.camel@Joe-Laptop>
Message-ID: <20110811090147.GD2732@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 01:20:27PM -0700, Joe Perches wrote:
> On Tue, 2011-08-09 at 10:16 +0100, Jamie Iles wrote:
> > macb is already using the dev_dbg() and friends helpers so use netdev_()
> > along with a pr_fmt() definition to make the printing a little cleaner.
> []
> > diff --git a/drivers/net/macb.c b/drivers/net/macb.c
> []
> > @@ -8,6 +8,7 @@
> []
> > +#define pr_fmt(fmt) "macb: " fmt
> 
> Hi Jamie.
> 
> Just trivia.
> 
> Please use #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt 
> instead.  There would be no output difference.
> 
> That'll make it easier to remove later when all of
> of these #defines pr_fmt that use just KBUILD_MODNAME
> can be removed.

I hadn't noticed KBUILD_MODNAME before, thanks for pointing that out 
Joe.  I'll update with this change.

Jamie
