From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Nov 2016 22:10:01 +0200
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <20161129210455.d0c8450d3ceb83c1abe521b0@free.fr>
References: <cover.1480414715.git.moinejf@free.fr> <6356753.Ekaj7GdA0W@avalon>
 <20161129210455.d0c8450d3ceb83c1abe521b0@free.fr>
Message-ID: <4502748.8rUF7ESxa4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

On Tuesday 29 Nov 2016 21:04:55 Jean-Francois Moine wrote:
> On Tue, 29 Nov 2016 21:33 +0200 Laurent Pinchart wrote:
> >>> You need a third port for the HDMI encoder output, connected to an
> >>> HDMI connector DT node.
> >> 
> >> I don't see what you mean. The HDMI device is both the encoder
> >> and connector (as the TDA998x):
> >
> > The driver might create both an encoder and a connector, but I very much
> > doubt that the "allwinner,sun8i-a83t-hdmi" hardware contains a connector,
> > unless the SoC package has an HDMI connector coming out of it :-)
> > 
> >> plane -> DE2 mixer ---> TCON -----> HDMI -----> display device
> >> ----- plane ------    - CRTC -   - encoder  \
> >>                                    connector -- (HDMI cable)
> >>          audio-controller -   - audio-codec /
> 
> The schema is the same as the Dove Cubox: the TDA998x is just a chip
> with some wires going out and the physical connector is supposed to be
> at the end of the wires.

I've missed the Dove Cubox DT bindings when they were submitted. Fortunately 
(or unfortunately for you, depending on how you look at it ;-)) I've paid more 
attention this time.

> Here, the HDMI pins of the SoC go to a pure hardware chip and then to
> the physical connector. Which software entity do you want to add?

I don't want to add a software entity, I just want to model the connector in 
DT as it's present in the system. Even though that's more common for other bus 
types than HDMI (LVDS for instance) it wouldn't be inconceivable to connect 
the HDMI signals to an on-board chim instead of an HDMI connector, so the HDMI 
encoder output should be modelled by a port and connected to a connector DT 
node in this case.

-- 
Regards,

Laurent Pinchart
