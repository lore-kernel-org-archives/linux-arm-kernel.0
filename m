From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 30 Nov 2016 10:27:57 +0100
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <4614815.L3DQhhBy6d@avalon>
References: <cover.1480414715.git.moinejf@free.fr> <4502748.8rUF7ESxa4@avalon>
 <20161130091208.f38cd79f1cc5d27b27f3b130@free.fr>
 <4614815.L3DQhhBy6d@avalon>
Message-ID: <20161130102757.9eec1f7f3377d0f4787e3829@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2016 10:20:21 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > Well, I don't see what this connector can be.
> > May you give me a DT example?
> 
> Sure.
> 
> arch/arm/boot/dts/r8a7791-koelsch.dts
> 
>         /* HDMI encoder */
> 
>         hdmi at 39 {
>                 compatible = "adi,adv7511w";
>                 reg = <0x39>;
>                 interrupt-parent = <&gpio3>;
>                 interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> 
>                 adi,input-depth = <8>;
>                 adi,input-colorspace = "rgb";
>                 adi,input-clock = "1x";
>                 adi,input-style = <1>;
>                 adi,input-justification = "evenly";
> 
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         port at 0 {
>                                 reg = <0>;
>                                 adv7511_in: endpoint {
>                                         remote-endpoint = <&du_out_rgb>;
>                                 };
>                         };
> 
>                         port at 1 {
>                                 reg = <1>;
>                                 adv7511_out: endpoint {
>                                         remote-endpoint = <&hdmi_con>;
>                                 };
>                         };
>                 };
>         };
> 
>         /* HDMI connector */
> 
>         hdmi-out {
>                 compatible = "hdmi-connector";
>                 type = "a";
> 
>                 port {
>                         hdmi_con: endpoint {
>                                 remote-endpoint = <&adv7511_out>;
>                         };
>                 };
>         };

Hi Laurent,

Sorry for I don't see the interest:
- it is obvious that the HDMI connector is a 'hdmi-connector'!
- the physical connector type may be changed on any board by a soldering
  iron or a connector to connector cable.
- what does the software do with the connector type?
- why not to put the connector information in the HDMI device?

And, if I follow you, the graph of ports could also be used to describe
the way the various parts of the SoCs are powered, to describe the pin
connections, to describe the USB connectors, to describe the board
internal hubs and bridges...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
