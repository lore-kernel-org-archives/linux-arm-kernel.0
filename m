From: sre@ring0.de (Sebastian Reichel)
Date: Wed, 30 Oct 2013 00:28:39 +0100
Subject: [PATCH v7 1/5] omap3isp: Modify clocks registration to avoid
 circular references
In-Reply-To: <16467881.81yEf9zq68@avalon>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <1383076268-8984-2-git-send-email-s.nawrocki@samsung.com>
 <16467881.81yEf9zq68@avalon>
Message-ID: <20131029232837.GB2266@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 29, 2013 at 11:28:37PM +0100, Laurent Pinchart wrote:
> On Tuesday 29 October 2013 20:51:04 Sylwester Nawrocki wrote:
> > The clock core code is going to be modified so clk_get() takes
> > reference on the clock provider module. Until the potential circular
> > reference issue is properly addressed, we pass NULL as as the first
> > argument to clk_register(), in order to disallow sub-devices taking
> > a reference on the ISP module back trough clk_get(). This should
> > prevent locking the modules in memory.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Do you plan to push this to mainline as part of this patch series ? I don't 
> have pending patches for the omap3isp that would conflict with this patch, so 
> that would be fine with me.

I plan to add support for DT to omap3isp + ADP1653 shortly. I have
not yet started to work on this, but expect to send some first RFC
patches in November.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/f3a370c8/attachment-0001.sig>
