From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 1 May 2016 17:48:56 +0200
Subject: Nokia N900 retention mode in v4.6, camera buttons fun
In-Reply-To: <20160501085236.GA14243@amd>
References: <20160411093023.GC11814@amd> <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com> <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd> <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd> <20160421130450.GQ29406@pali>
 <20160429200559.GA16598@earth> <20160501085236.GA14243@amd>
Message-ID: <20160501154855.GA24970@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 01, 2016 at 10:52:36AM +0200, Pavel Machek wrote:
> On Fri 2016-04-29 22:06:00, Sebastian Reichel wrote:
> > On Thu, Apr 21, 2016 at 03:04:50PM +0200, Pali Roh?r wrote:
> > > > CONFIG_HSI breaks power management completely, so power management
> > > > with modem will be another topic.  
> > > 
> > > Sebastian, any idea why power management does not work for HSI?
> > 
> > I wasn't aware, that pm_runtime_irq_safe() basically breaks runtime
> > PM until Tony's fix for musb (even though it's logical when thinking
> > about it). Currently omap-ssi and omap-ssi-port make use of
> > pm_runtime_irq_safe().
> > 
> > Since pm_runtime_get_sync/pm_runtime_put_sync is called from
> > tasklets in omap-ssi (and omap-ssi-port) it cannot be simply
> > removed. So fixing PM for the ssi controller requires reworking
> > the driver in a non trivial way.
> 
> I see latest series, and it also talks about frequency scaling. But I
> guess it is not going to fix this issue?

No, this is independent of the runtime PM problems. I also worked
on runtime PM/idling yesterday and pm_runtime_irq_safe is the main
culprit for breaking it (not the only one, though). It's not yet
finished though

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160501/4466ff82/attachment-0001.sig>
