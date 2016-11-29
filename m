From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Nov 2016 21:04:55 +0100
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <6356753.Ekaj7GdA0W@avalon>
References: <cover.1480414715.git.moinejf@free.fr> <5996605.Gh0PjPIAcn@avalon>
 <20161129202751.e94f72a1b9e2c2fb064e9933@free.fr>
 <6356753.Ekaj7GdA0W@avalon>
Message-ID: <20161129210455.d0c8450d3ceb83c1abe521b0@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Nov 2016 21:33 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > > You need a third port for the HDMI encoder output, connected to an HDMI
> > > connector DT node.
> > 
> > I don't see what you mean. The HDMI device is both the encoder
> > and connector (as the TDA998x):
> 
> The driver might create both an encoder and a connector, but I very much doubt 
> that the "allwinner,sun8i-a83t-hdmi" hardware contains a connector, unless the 
> SoC package has an HDMI connector coming out of it :-)
> 
> > plane -> DE2 mixer ---> TCON -----> HDMI -----> display device
> > ----- plane ------    - CRTC -   - encoder  \
> >                                    connector -- (HDMI cable)
> >          audio-controller -   - audio-codec /

The schema is the same as the Dove Cubox: the TDA998x is just a chip
with some wires going out and the physical connector is supposed to be
at the end of the wires.

Here, the HDMI pins of the SoC go to a pure hardware chip and then to
the physical connector. Which software entity do you want to add?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
