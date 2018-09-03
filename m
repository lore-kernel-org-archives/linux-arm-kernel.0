From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 3 Sep 2018 09:43:15 +0200
Subject: [PATCH v3 00/13] remove_conflicting_framebuffers() cleanup
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
 <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
Message-ID: <20180903074315.GB21634@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2018 at 04:08:41PM +0200, Micha? Miros?aw wrote:
> This series cleans up duplicated code for replacing firmware FB
> driver with proper DRI driver and adds handover support to
> Tegra driver.
> 
> This is a sligtly updated version of a series sent on 24 Nov 2017.
> 
> ---
> v2:
>  - rebased on current drm-next
>  - dropped staging/sm750fb changes
>  - added kernel docs for DRM helpers
> v3:
>  - move kerneldoc to fbdev, where functions are implemented
>  - split kerneldoc for remove_conflicting_framebuffers()

Ah, that's not quite what I had in mind. I think having the docs (also) in
the drm helpers would be good, since that's where drm people will look,
and that's the function they'll call. I just wanted you to split the fbdev
and drm parts into 2 patches (since those are two different maintainers).

Anyway, this is ok too, so imo ready for merging. If you can resurrect the
drm docs (with a patch title of "drm/fb-helper: document fbdev remove
functions" or similar) that would be great.

Only thing we need for merging now is the ack from Bartlomiej.
-Daniel

>  - propagate return value in remove_conflicting_pci_framebuffers()
> 
> ---
> Micha? Miros?aw (13):
>   fbdev: show fbdev number for debugging
>   fbdev: allow apertures == NULL in remove_conflicting_framebuffers()
>   fbdev: add kerneldoc do remove_conflicting_framebuffers()
>   fbdev: add remove_conflicting_pci_framebuffers()
>   drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
>   drm/bochs: use simpler remove_conflicting_pci_framebuffers()
>   drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
>   drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
>   drm/radeon: use simpler remove_conflicting_pci_framebuffers()
>   drm/virtio: use simpler remove_conflicting_pci_framebuffers()
>   drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
>   drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
>   drm/tegra: kick out simplefb
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 +--------
>  drivers/gpu/drm/bochs/bochs_drv.c        | 18 +------
>  drivers/gpu/drm/cirrus/cirrus_drv.c      | 23 +--------
>  drivers/gpu/drm/mgag200/mgag200_drv.c    | 21 +-------
>  drivers/gpu/drm/mgag200/mgag200_main.c   |  9 ----
>  drivers/gpu/drm/radeon/radeon_drv.c      | 23 +--------
>  drivers/gpu/drm/sun4i/sun4i_drv.c        | 18 +------
>  drivers/gpu/drm/tegra/drm.c              |  4 ++
>  drivers/gpu/drm/vc4/vc4_drv.c            | 20 +-------
>  drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 ++-------
>  drivers/video/fbdev/core/fbmem.c         | 63 +++++++++++++++++++++++-
>  include/drm/drm_fb_helper.h              | 12 +++++
>  include/linux/fb.h                       |  2 +
>  13 files changed, 89 insertions(+), 172 deletions(-)
> 
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
