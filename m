From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Wed, 13 Jul 2016 19:05:29 +0100
Subject: [PATCH 1/2] drm/sun4i: Remove redundant call to
 drm_connector_unregister_all()
In-Reply-To: <CAOw6vbLmOd_pPD9sRODweNS347vhZJhBckashKuoG5ekro9BbQ@mail.gmail.com>
References: <1468427947-28037-1-git-send-email-chris@chris-wilson.co.uk>
 <CAOw6vbLmOd_pPD9sRODweNS347vhZJhBckashKuoG5ekro9BbQ@mail.gmail.com>
Message-ID: <20160713180529.GN6157@nuc-i3427.alporthouse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 10:56:58AM -0700, Sean Paul wrote:
> On Wed, Jul 13, 2016 at 9:39 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > drm_connector_unregister_all() is automatically called by
> > drm_dev_unregister() and so the manual call can be dropped.
> >
> 
> The documentation for drm_connector_unregister_all says "Drivers
> should call this [...] right before calling drm_dev_unregister()". If
> this is no longer true, could you update that comment as part of this
> series?

That is done. (The comment block is entirely removed so that we don't
distract authors with superfluous functions that they cannot call
themselves, i.e. Daniel wanted only the DRM interfaces documented.)
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
