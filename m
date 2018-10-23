From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Oct 2018 10:11:08 -0500
Subject: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16
 MIPI-DSI panel bindings
In-Reply-To: <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-10-jagan@amarulasolutions.com>
 <20181015182448.GA7134@bogus>
 <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com>
Message-ID: <CAL_JsqJPn9hhGsk62RzLc1dPQyF2_iCSau+MvY9mD_QADybgvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2018 at 5:22 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi Rob,
>
> On Mon, Oct 15, 2018 at 7:24 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, 27 Sep 2018 17:18:47 +0530, Jagan Teki wrote:
> > > Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
> > > same panel PCB comes with parallel RBG which is supported via
> > > panel-simple with "bananapi,s070wv20-ct16" compatible.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> This "panel" is actually an RGB panel with a MIPI-DSI-to-RGB bridge
> tacked on. On one particular revision of this module, one can also
> directly use the RGB interface.
>
> Would it be better to model this as bridge+panel? We already have
> a binding for the RGB version [1]. This would make it harder to
> make a driver though, as there is no publicly available datasheet
> for the bridge chip, so it's likely that part of the init sequence
> would have to be hard-coded.

Perhaps you can use the same compatible and detect based on the OF
graph connection whether it is DSI or RGB interface? That would mean
the RGB version doesn't use simple-panel driver, but that should be
okay.

If there's other users of this bridge chip, then modeling the bridge
separately would be better.

Rob
