From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:05 -0500
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161024140419.ah6hywf3b24pj3fv@lukather>
 <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
Message-ID: <20161030204104.cexblg73q4owe2gt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 04:14:41PM +0200, Jean-Francois Moine wrote:
> On Mon, 24 Oct 2016 16:04:19 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi,
> 
> Hi Maxime,
> 
> > On Fri, Oct 21, 2016 at 09:26:18AM +0200, Jean-Francois Moine wrote:
> > > Allwinner's recent SoCs, as A64, A83T and H3, contain a new display
> > > engine, DE2.
> > > This patch adds a DRM video driver for this device.
> > > 
> > > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > 
> > Output from checkpatch:
> > total: 0 errors, 20 warnings, 83 checks, 1799 lines checked
> > 
> > > ---
> > >  .../bindings/display/sunxi/sunxi-de2.txt           |  83 +++
> > >  drivers/gpu/drm/Kconfig                            |   2 +
> > >  drivers/gpu/drm/Makefile                           |   1 +
> > >  drivers/gpu/drm/sunxi/Kconfig                      |  21 +
> > >  drivers/gpu/drm/sunxi/Makefile                     |   7 +
> > >  drivers/gpu/drm/sunxi/de2_crtc.c                   | 475 +++++++++++++++++
> > >  drivers/gpu/drm/sunxi/de2_crtc.h                   |  63 +++
> > >  drivers/gpu/drm/sunxi/de2_de.c                     | 591 +++++++++++++++++++++
> > >  drivers/gpu/drm/sunxi/de2_drm.h                    |  47 ++
> > >  drivers/gpu/drm/sunxi/de2_drv.c                    | 378 +++++++++++++
> > >  drivers/gpu/drm/sunxi/de2_plane.c                  | 119 +++++
> > >  11 files changed, 1787 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
> > >  create mode 100644 drivers/gpu/drm/sunxi/Kconfig
> > >  create mode 100644 drivers/gpu/drm/sunxi/Makefile
> > >  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
> > >  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
> > >  create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
> > >  create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
> > >  create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
> > >  create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
> > > new file mode 100644
> > > index 0000000..f9cd67a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt

[...]

> > > +
> > > +- resets: phandle to the reset of the device
> > > +
> > > +- ports: phandle's to the LCD ports
> > 
> > Please use the OF graph.
> 
> These ports are references to the graph of nodes. See
> 	http://www.kernelhub.org/?msg=911825&p=2

I think what Maxime means is describe the DE to LCD connection with OF 
graph, not just a phandle.

Rob
