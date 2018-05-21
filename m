From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 21 May 2018 17:10:24 +0200
Subject: [PATCH 04/15] dt-bindings: display: sunxi-drm: Add TCON TOP
 description
In-Reply-To: <20180521080147.72esi2kwzcvzmetk@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-5-jernej.skrabec@siol.net>
 <20180521080147.72esi2kwzcvzmetk@flea>
Message-ID: <5513047.T4egid1SBs@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne ponedeljek, 21. maj 2018 ob 10:01:47 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sat, May 19, 2018 at 08:31:16PM +0200, Jernej Skrabec wrote:
> > TCON TOP main purpose is to configure whole display pipeline. It
> > determines relationships between mixers and TCONs, selects source TCON
> > for HDMI, muxes LCD and TV encoder GPIO output,
> 
> I'm not sure you mean GPIO here, but rather pin?

Right, I'll fix that.

> 
> > selects TV encoder clock source and contains additional TV TCON and
> > DSI gates.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  .../bindings/display/sunxi/sun4i-drm.txt      | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> > 3346c1e2a7a0..a099957ab62a 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > 
> > @@ -187,6 +187,26 @@ And on the A23, A31, A31s and A33, you need one more 
clock line:
> >     - 'lvds-alt': An alternative clock source, separate from the TCON
> >     channel 0
> >     
> >                   clock, that can be used to drive the LVDS clock
> > 
> > +TCON TOP
> > +--------
> > +
> > +TCON TOPs main purpose is to configure whole display pipeline. It
> > determines +relationships between mixers and TCONs, selects source TCON
> > for HDMI, muxes +LCD and TV encoder GPIO output, selects TV encoder clock
> > source and contains +additional TV TCON and DSI gates.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun8i-r40-tcon-top
> > +  - reg: base address and size of the memory-mapped region.
> > +  - clocks: phandle to the clocks feeding the TCON TOP
> > +    * bus: TCON TOP interface clock
> > +  - clock-names: clock name mentioned above
> > +  - resets: phandle to the reset line driving the DRC
> > +    * rst: TCON TOP reset line
> > +  - reset-names: reset name mentioned above
> > +  - #clock-cells : must contain 1
> > +
> 
> I guess you should better describe the OF-graph endpoints, and the
> clocks output. Just using the binding additions here doesn't allow to
> get a clear idea of how the DT should look like.

With my idea of implementation, OF graph is the same as before, so I didn't 
mention anything about it.

My idea of dependencies (you should view it in fixed width font):
         TCON-TOP
            ^
            |
mixer <-> TCON <-> HDMI

I'll explain my design decision as response to other mail.

Best regards,
Jernej
