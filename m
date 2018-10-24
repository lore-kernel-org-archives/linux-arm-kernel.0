From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Oct 2018 21:36:57 +0100
Subject: [PATCH v2 10/15] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <20181024180754.pfae27y6i7jhcdgy@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-11-jagan@amarulasolutions.com>
 <20181024180754.pfae27y6i7jhcdgy@flea>
Message-ID: <CAGb2v67NeVjB7b57pmUN3rw8JsE+3CKEDXtT-91GiFvRRaU3cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 7:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Oct 23, 2018 at 09:20:30PM +0530, Jagan Teki wrote:
> > Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge panel,
> > the same panel PCB comes with parallel RBG which is supported via
> > panel-simple driver with "bananapi,s070wv20-ct16" compatible.
> >
> > But this binding is specific for MIPI DSI to RGB bridge panels,
> > which usually accessed using MIPI DSI controller driver.
> >
> > for information:
> > - "bananapi,s070wv20-ct16" compatible for parallel RGB panels
> > - "bananapi,s070wv20-ct16-icn6211" compatible for MIPI-DSI to RGB
> > bridge panels
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Why not just reusing the same binding document?

Agreed. Just put the MIPI-DSI-specific information you added here
into the existing document.

Rob suggested that we could even use the same compatible. That would
make sense if you are modelling the entire panel + PCB as a module,
instead of a panel node + a bridge node as I originally wanted.
Don't worry, I gave it some thought and I think having a single
combined panel node makes more sense.

ChenYu
