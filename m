From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Oct 2013 00:55:06 +0100
Subject: [PATCH v7 1/5] omap3isp: Modify clocks registration to avoid
 circular references
In-Reply-To: <20131029232837.GB2266@earth.universe>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <16467881.81yEf9zq68@avalon> <20131029232837.GB2266@earth.universe>
Message-ID: <15201376.PVPE5NrGdO@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wednesday 30 October 2013 00:28:39 Sebastian Reichel wrote:
> On Tue, Oct 29, 2013 at 11:28:37PM +0100, Laurent Pinchart wrote:
> > On Tuesday 29 October 2013 20:51:04 Sylwester Nawrocki wrote:
> > > The clock core code is going to be modified so clk_get() takes
> > > reference on the clock provider module. Until the potential circular
> > > reference issue is properly addressed, we pass NULL as as the first
> > > argument to clk_register(), in order to disallow sub-devices taking
> > > a reference on the ISP module back trough clk_get(). This should
> > > prevent locking the modules in memory.
> > > 
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Do you plan to push this to mainline as part of this patch series ? I
> > don't have pending patches for the omap3isp that would conflict with this
> > patch, so that would be fine with me.
> 
> I plan to add support for DT to omap3isp + ADP1653 shortly. I have
> not yet started to work on this, but expect to send some first RFC
> patches in November.

That's very nice to hear ! And thanks for the heads up, I would have started 
working on it shortly.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/789c7a56/attachment.sig>
