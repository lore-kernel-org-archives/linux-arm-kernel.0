From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 24 May 2016 10:41:30 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v5
In-Reply-To: <20160524083749.GR27098@phenom.ffwll.local>
References: <1464074761-5194-1-git-send-email-tomeu.vizoso@collabora.com>
 <20160524083050.GQ27098@phenom.ffwll.local>
 <20160524083749.GR27098@phenom.ffwll.local>
Message-ID: <1885816.5oayNdNrp7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 24. Mai 2016, 10:37:49 schrieb Daniel Vetter:
> On Tue, May 24, 2016 at 10:30:50AM +0200, Daniel Vetter wrote:
> > On Tue, May 24, 2016 at 10:28:42AM +0200, Heiko Stuebner wrote:
> > > Hi Tomeu,
> > > 
> > > Patch subject: please put the version into the brackets, so [PATCH v5]
> > > as it shouldn't be part of the commit log.
> > > 
> > > Am Dienstag, 24. Mai 2016, 09:27:37 schrieb Tomeu Vizoso:
> > > > As per the docs, atomic_commit should return -EBUSY "if an
> > > > asycnhronous
> > > > updated is requested and there is an earlier updated pending".
> > > > 
> > > > v2: Use the status of the workqueue instead of vop->event, and don't
> > > > add
> > > > a superfluous wait on the workqueue.
> > > > 
> > > > v3: Drop work_busy, as there's a sizeable delay when the worker
> > > > finishes, which introduces a race in which the client has already
> > > > received the last flip event but the next page flip ioctl will still
> > > > return -EBUSY because work_busy returns outdated information.
> > > > 
> > > > v4: Hold dev->event_lock while checking the VOP's event field as
> > > > suggested by Daniel Stone.
> > > > 
> > > > v5: Only block if there's outstanding work if it's a blocking call.
> > > 
> > > similarly, please put the changelog below the "---" and above the
> > > diffstat.> 
> > drm culture is to keep it above, since it's kinda useful sometimes when
> > later on trying to reconstruct wtf was discussed and why a patch was
> > merged.
> 
> Maybe needs a bit more context: The only stuff you raised in your review
> is tiny style nits of pretty much utter irrelevance. No substantial and
> material feedback anywehere, and in my opinion in such a case either fix
> up the nits when applying (when you feel really strongly about perfect
> patches), or just merge as-is.
> 
> But sending out content-less bikesheds like these just adds noise and
> helps no-one. I think at least some spelling stuff is the minimal bar (but
> then just include your r-b tag), but personally I don't even care about
> that so much, as long as it's still legible.

ok, will keep that (both mails) in mind for future stuff.

Heiko
