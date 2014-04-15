From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Apr 2014 01:00:36 +0200
Subject: [PATCH/RFC 0/3] Allow OHCI drivers to override hub control
 operations
In-Reply-To: <Pine.LNX.4.44L0.1404151402250.1310-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1404151402250.1310-100000@iolanthe.rowland.org>
Message-ID: <1563131.ShpASGpY9t@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Tuesday 15 April 2014 14:05:14 Alan Stern wrote:
> On Tue, 15 Apr 2014, Laurent Pinchart wrote:
> > > I'm open to the idea of exporting the hub functions. In the end, it
> > > doesn't make all that much difference (it would save a little object
> > > code).
> > 
> > I would have agreed to keep the code as it is today if you had thought
> > that exporting the hub functions was a really bad idea, but as you're open
> > to it, and as it removes a bit of code without much of a drawback, I think
> > it makes sense to perform that optimization.
> 
> Agreed.  We aren't really _encouraging_ people to do this, because it
> still takes some manual work to override the default operation.
> 
> > By the way, as a second step, do you think it would make sense to handle
> > the vbus regulators directly in ohci_hub_control() ?
> 
> I don't see any good way of doing this generically.  Since it is
> currently needed only for PXA27x, we don't know what other
> architectures will require in the future.

Fine with me, let's revisit this later if needed then.

-- 
Regards,

Laurent Pinchart
