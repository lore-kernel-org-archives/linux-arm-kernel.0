From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Mon, 5 Nov 2018 15:02:28 +0100
Subject: [PATCH 0/2] drm/meson: Allow using optional canvas provider
In-Reply-To: <1a3d3b7a-5050-7b4c-bda6-8ef532403d01@baylibre.com>
References: <20181105104508.23090-1-mjourdan@baylibre.com>
 <1a3d3b7a-5050-7b4c-bda6-8ef532403d01@baylibre.com>
Message-ID: <CAMO6nax_Q4kbDkeBmYQezo9dpMztD4DMFh+1dewax4p6d_S7mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Mon, Nov 5, 2018 at 1:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Maxime,
>
> On 05/11/2018 11:45, Maxime Jourdan wrote:
> > The meson DRM driver currently uses constant, static canvas indexes.
> >
> > This is not optimal and could conflict with other drivers also using
> > canvases.
>
> Indeed, it's now time to use the canvas provider merged in 4.20-rc1 !
>
> >
> > This patch series allows the driver to optionnally use a canvas provider
> > module that is able to dispatch canvases, on demand and free of conflict.
> >
> > In the future, the current way of doing things will be deprecated.
>
> Do you confirm you will send a patch to remove the legacy canvas code when
> everything is merged (including DT changes) ?
>
> I'll wait until the bindings are reviewed, then I'll push the serie to drm-misc-next.
>

Yes, ultimately it will be removed.

The plan is:

4.21: allow using both modes, add the "amlogic,canvas" property to the dts files
4.22: remove the old way and change the amlogic,canvas property to mandatory

This should allow for a nice transition.

Maxime

> Thanks,
> Neil
>
> >
> > Maxime Jourdan (2):
> >   dt-bindings: display: amlogic, meson-vpu: Add optional canvas provider
> >     node
> >   drm/meson: Use optional canvas provider
> >
> >  .../bindings/display/amlogic,meson-vpu.txt    |  2 +
> >  drivers/gpu/drm/meson/Kconfig                 |  1 +
> >  drivers/gpu/drm/meson/meson_crtc.c            | 14 ++++--
> >  drivers/gpu/drm/meson/meson_drv.c             | 46 ++++++++++++-------
> >  drivers/gpu/drm/meson/meson_drv.h             |  4 ++
> >  drivers/gpu/drm/meson/meson_plane.c           |  8 +++-
> >  6 files changed, 53 insertions(+), 22 deletions(-)
> >
