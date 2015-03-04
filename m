From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 4 Mar 2015 08:51:53 +0800
Subject: [PATCH] ARM: dts: imx: Add dr_mode host setting to all host-only
 usb instances
In-Reply-To: <20150303150809.GD30263@beef>
References: <1425045960-14191-1-git-send-email-mporter@konsulko.com>
 <20150303034133.GJ20455@dragon> <20150303044334.GA16617@shlinux2>
 <20150303150809.GD30263@beef>
Message-ID: <20150304005152.GA23399@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 10:08:09AM -0500, Matt Porter wrote:
> On Tue, Mar 03, 2015 at 12:43:36PM +0800, Peter Chen wrote:
> > On Tue, Mar 03, 2015 at 11:41:35AM +0800, Shawn Guo wrote:
> > > 
> > > On Fri, Feb 27, 2015 at 09:06:00AM -0500, Matt Porter wrote:
> > > > The chipidea driver adds an extra line of spam to the log when a
> > > > host-only chipidea instance is left set to the default of a dual role
> > > > controller.
> > > > 
> > > > [    2.010873] ci_hdrc ci_hdrc.1: doesn't support gadget
> > > > 
> > > > Set the dr_mode property to host on all the host-only nodes
> > > > to avoid this warning.
> > 
> > It is not an warning, it is dev_info.
> 
> True enough, it's info level but is essentially warning that, in the
> case of instances that are restricted to host only (at the SoC level),
> that the DT hardware description is incorrect. Yes, it's benign, but
> if the dtsi is corrected for those parts we don't have to see that
> message.

You are right.

> 
> > In fact, imx28, imx6sl and imx6sx's second controller is dual-role
> > controller, we only set dr_mode at board's dts according to design
> > unless the controller's capability register is incorrect.
> 
> The patch doesn't set dr_mode to host on the second controller for
> the imx6sl or imx6sx, only on the third host-only controller. If
> imx28's second controller is really dual-role capable then the
> reference manual is incorrect and I can drop that hunk in v2.
> I only have imx6q and imx6d parts in hand to verify so for the rest
> I went by the RM claim of which controllers were host-only.

Maybe IC guys don't want to export that imx28's that capabilities,
so don't need to change.

> 
> > So, sorry, I don't think this change is necessary.
> 
> I can correct the set of instances that should have dr_mode set to host
> in v2 of this. We clearly have some that should have this set in their
> SoC .dtsi to have the hardware description correct.  Will that work for
> you or do you want the SoC-specific cases of this property to be only
> reflected in the board level dts?
> 

After thinking more, it is a benefit fix, and doesn't need to do any
changes, thanks.

Acked-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
