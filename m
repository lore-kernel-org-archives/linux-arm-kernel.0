From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 29 Jun 2018 21:32:59 +0200
Subject: [linux-sunxi] Re: [PATCH v3 15/24] dt-bindings: display:
 sun4i-drm: Add description of A64 HDMI PHY
In-Reply-To: <CAGb2v67iRZZTQuTH8inwmPC6S0BRecFgPEpKrxgThQbsYaZgmQ@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <1669385.k4L9lni8DF@jernej-laptop>
 <CAGb2v67iRZZTQuTH8inwmPC6S0BRecFgPEpKrxgThQbsYaZgmQ@mail.gmail.com>
Message-ID: <1814959.07NGAI1aoU@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 28. junij 2018 ob 09:00:32 CEST je Chen-Yu Tsai napisal(a):
> On Thu, Jun 28, 2018 at 12:51 PM, Jernej ?krabec
> 
> <jernej.skrabec@siol.net> wrote:
> > Dne ?etrtek, 28. junij 2018 ob 04:19:55 CEST je Chen-Yu Tsai napisal(a):
> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > wrote:
> >> > A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
> >> > clock parents. It is compatible to other HDMI PHYs, like that found in
> >> > R40.
> >> > 
> >> > Acked-by: Rob Herring <robh@kernel.org>
> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> > ---
> >> > 
> >> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> > 
> >> > diff --git
> >> > a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> >> > 84fe38dbb900..dc83f21ef188 100644
> >> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >> > @@ -101,6 +101,7 @@ DWC HDMI PHY
> >> > 
> >> >  Required properties:
> >> >    - compatible: value must be one of:
> >> > +    * allwinner,sun50i-a64-hdmi-phy
> >> > 
> >> >      * allwinner,sun8i-a83t-hdmi-phy
> >> >      * allwinner,sun8i-h3-hdmi-phy
> >> 
> >> Nit: the list is sorted by family first, then SoC name, so it should
> >> be the last on the list.
> > 
> > I went alphabetically, since "5" is before "8"...
> 
> I see. I think version sort applies here, given that sun50i is newer
> than sun8i.

Should I make a patch for that?

Best regards,
Jernej

> 
> ChenYu
> 
> > Best regards,
> > Jernej
> > 
> >> Otherwise,
> >> 
> >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >> 
> >> >    - reg: base address and size of memory-mapped region
> >> > 
> >> > @@ -111,8 +112,9 @@ Required properties:
> >> >    - resets: phandle to the reset controller driving the PHY
> >> >    - reset-names: must be "phy"
> >> > 
> >> > -H3 HDMI PHY requires additional clock:
> >> > 
> >> > +H3 and A64 HDMI PHY require additional clocks:
> >> >    - pll-0: parent of phy clock
> >> > 
> >> > +  - pll-1: second possible phy clock parent (A64 only)
> >> > 
> >> >  TV Encoder
> >> >  ----------
> >> > 
> >> > --
> >> > 2.18.0
> > 
> > --
> > You received this message because you are subscribed to the Google Groups
> > "linux-sunxi" group. To unsubscribe from this group and stop receiving
> > emails from it, send an email to
> > linux-sunxi+unsubscribe at googlegroups.com. For more options, visit
> > https://groups.google.com/d/optout.
