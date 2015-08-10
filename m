From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 10 Aug 2015 19:11:49 +0200
Subject: [PATCH 18/23] power/reset: at91-reset: get and use slow clock
In-Reply-To: <20150810155005.GH3411@piout.net>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
 <20150805182220.GC11315@earth> <20150810155005.GH3411@piout.net>
Message-ID: <20150810171148.GA21858@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 10, 2015 at 05:50:05PM +0200, Alexandre Belloni wrote:
> On 05/08/2015 at 20:22:20 +0200, Sebastian Reichel wrote :
> > On Fri, Jul 31, 2015 at 11:39:54AM +0200, Alexandre Belloni wrote:
> > > Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> > > hang") added a workaround for the slow clock as it is not properly handled
> > > by its users.
> > > 
> > > Get and use the slow clock as it is necessary for the at91 reset
> > > controller.
> > 
> > You call clk_prepare_enable during probe without a matching
> > clk_disable_unprepare on module removal.
> 
> They will never be compiled as modules as the Kconfig option is a
> bool so we don't have a .remove and the module will never be removed.

In that case the module_platform_driver() statement at the bottom
should be replaced with builtin_platform_driver().

> Do you want me to change at91-reset and at91-poweroff to work as
> modules?

That would also be fine.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150810/0d904b01/attachment.sig>
