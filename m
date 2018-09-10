From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Sep 2018 15:24:37 +0300
Subject: omap4: support for manually updated display
In-Reply-To: <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
Message-ID: <3205865.8O8aibZXye@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, 10 September 2018 14:59:23 EEST Tomi Valkeinen wrote:
> Hi Pavel,
> 
> (dropping Dave, no need to spam him)
> 
> On 30/08/18 12:04, Pavel Machek wrote:
> > Hi!
> > 
> > There's neat series of patches on
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/
> > ?h=droid4-pending-v4.19
> > 
> > They enable display support for my hardware. As you can imagine,
> > display is rather important for a cellphone.
> > 
> > Tomi, can you take the patches? I can resubmit them in email, or
> > shuffle them to another branch without mfd changes, or clean them up
> > etc...
> 
> A large omapdrm change set from Laurent was merged into drm-next, and
> I'm certain they conflict with this series. Laurent also has continued
> that work, and while those new patches haven't been sent for review yet,
> I fear they'll also conflict with these.
> 
> So in the minimum, a rebase on top of drm-next is needed.
> 
> I also continue to be very worried that adding DSI support to omapdrm at
> this stage will be a huge extra burden for Laurent's work.
> 
> We should transform the panel-dsi-cm.c towards the common DRM model.
> With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> panel. So possibly all the DSI features are there in the DRM framework,
> but someone needs to check that and start working on panel-dsi-cm.c so
> that it's ready when we finally switch to the DRM model.
> 
> In my opinion, which I've also expressed before, the above work is much
> easier to do by first changing the omapdrm to DRM model, without any DSI
> displays, and then add the DSI command mode support. But if people
> insist on adding the DSI support already now, I would appreciate the
> same people working on the DSI support so that Laurent doesn't have to
> do it all.

I want to make it clear that I don't want to claim any privilege in getting 
patches merged first. I am however worried that, without an easy way to test 
DSI support, and without enough time to focus on it, I would break whatever 
would be merged now in future reworks. I would thus like to find out how to 
collaborate on this task, hopefully to move towards usage of drm_bridge and 
drm_panel for DSI-based pipelines.

-- 
Regards,

Laurent Pinchart
