From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:20:31 +0900
Subject: [PATCH 10/12] usb: r8a66597-hcd: Convert to clk_prepare/unprepare
In-Reply-To: <10742564.mkbtL7U7WC@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1900311.xc3BDUDvCy@avalon> <20131126023608.GA682@kroah.com>
 <10742564.mkbtL7U7WC@avalon>
Message-ID: <20131128082030.GU24146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:08:27PM +0100, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Monday 25 November 2013 18:36:08 Greg Kroah-Hartman wrote:
> > On Tue, Nov 26, 2013 at 03:00:30AM +0100, Laurent Pinchart wrote:
> > > On Saturday 09 November 2013 08:10:59 Greg Kroah-Hartman wrote:
> > > > On Sat, Nov 09, 2013 at 03:12:05PM +0100, Laurent Pinchart wrote:
> > > > > On Tuesday 29 October 2013 18:47:26 Shimoda, Yoshihiro wrote:
> > > > > > Hi Laurent-san,
> > > > > > 
> > > > > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > > > > Turn clk_enable() and clk_disable() calls into
> > > > > > > clk_prepare_enable() and clk_disable_unprepare() to get ready for
> > > > > > > the migration to the common clock framework.
> > > > > > > 
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > > > Cc: linux-usb at vger.kernel.org
> > > > > > > Signed-off-by: Laurent Pinchart
> > > > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > > 
> > > > > > Thank you for the patch.
> > > > > > 
> > > > > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > 
> > > > > Could you please pick this patch up ?
> > > > 
> > > > I'll pick things up after 3.13-rc1 is out, I can't do anything until
> > > > then.
> > > 
> > > Sure.
> > > 
> > > As this patch is a dependency for other series that will go through
> > > different trees, could you please provide a stable branch in your tree
> > > with this patch included that you will push to v3.14 ?
> > 
> > If you need this for other work, feel free to take it in your tree, I
> > have no real need for it to go in mine.
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Sounds good to me, thanks.
> 
> Simon, could you please pick this patch then ?

Sure. I have queued it up.
But I may not push it for a day or two.
