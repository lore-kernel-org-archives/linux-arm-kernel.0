From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Sep 2018 14:54:28 +0200
Subject: omap4: support for manually updated display
In-Reply-To: <20180910212820.ygr3japdw6td2qvm@earth.universe>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910212820.ygr3japdw6td2qvm@earth.universe>
Message-ID: <20180911125428.GA24639@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > A large omapdrm change set from Laurent was merged into drm-next, and
> > > I'm certain they conflict with this series. Laurent also has continued
> > > that work, and while those new patches haven't been sent for review yet,
> > > I fear they'll also conflict with these.
> > > 
> > > So in the minimum, a rebase on top of drm-next is needed.
> > > 
> > > I also continue to be very worried that adding DSI support to omapdrm at
> > > this stage will be a huge extra burden for Laurent's work.
> > > 
> > > We should transform the panel-dsi-cm.c towards the common DRM model.
> > > With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> > > panel. So possibly all the DSI features are there in the DRM framework,
> > > but someone needs to check that and start working on panel-dsi-cm.c so
> > > that it's ready when we finally switch to the DRM model.
> > > 
> > > In my opinion, which I've also expressed before, the above work is much
> > > easier to do by first changing the omapdrm to DRM model, without any DSI
> > > displays, and then add the DSI command mode support. But if people
> > > insist on adding the DSI support already now, I would appreciate the
> > > same people working on the DSI support so that Laurent doesn't have to
> > > do it all.
> > 
> > I want to make it clear that I don't want to claim any privilege in getting 
> > patches merged first. I am however worried that, without an easy way to test 
> > DSI support, and without enough time to focus on it, I would break whatever 
> > would be merged now in future reworks. I would thus like to find out how to 
> > collaborate on this task, hopefully to move towards usage of drm_bridge and 
> > drm_panel for DSI-based pipelines.
> 
> I'm currently quite busy and barely find enough time to do my work
> as power-supply subsystem maintainer, but I already started to
> rebase the series. I agree, that it would be very nice to move towards
> usage of common DRM framework(s), but it's also nice to see which
> patch breaks DSI ;)

I was thinking of doing rebase myself... so if you need some help, or
run out of a time and will need someone to finish it, let me know.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/1361818d/attachment.sig>
