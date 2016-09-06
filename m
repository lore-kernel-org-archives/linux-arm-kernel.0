From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Sep 2016 15:59:39 +0200
Subject: [linux-sunxi] [PATCH 3/7] drm/sun4i: Add SAT and DRC drivers
In-Reply-To: <8737lfwhz9.fsf@dell.be.48ers.dk>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-4-maxime.ripard@free-electrons.com>
 <8737lfwhz9.fsf@dell.be.48ers.dk>
Message-ID: <20160906135939.GF9040@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sun, Sep 04, 2016 at 10:03:06PM +0200, Peter Korsgaard wrote:
> >>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
> Hi,
> 
>  > The A33 pipeline also has some new components called SAT and DRC. Even
>  > though their exact features and programming model is not known (or
>  > documented), they need to be clocked for the pipeline to carry the video
>  > signal all the way.
> 
>  > Add minimal drivers for those that just claim the needed resources for the
>  > pipeline to operate properly.
> 
>  > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>  > ---
>  >  .../bindings/display/sunxi/sun4i-drm.txt           |  37 +++++++
>  >  drivers/gpu/drm/sun4i/Makefile                     |   3 +-
>  >  drivers/gpu/drm/sun4i/sun6i_drc.c                  | 117 +++++++++++++++++++++
>  >  drivers/gpu/drm/sun4i/sun8i_sat.c                  | 105 ++++++++++++++++++
>  >  4 files changed, 261 insertions(+), 1 deletion(-)
>  >  create mode 100644 drivers/gpu/drm/sun4i/sun6i_drc.c
>  >  create mode 100644 drivers/gpu/drm/sun4i/sun8i_sat.c
> 
>  > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>  > index d467ea93ac08..87c3c8dd34cb 100644
>  > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>  > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>  > @@ -51,6 +51,43 @@ Required properties:
>  >    second the block connected to the TCON channel 1 (usually the TV
>  >    encoder)
>  
>  > +SAT
>  > +---
>  > +
>  > +The SAT, found in the A33, allows to do some color correction.
>  > +
>  > +Required properties:
>  > +  - compatible: value must be one of:
>  > +    * allwinner,sun8i-a33-sat
>  > +  - reg: base address and size of the memory-mapped region.
>  > +  - clock: phandles to bus clock feeding the SAT
>  > +  - resets: phandles to the reset line driving the SAT
>  > +
>  > +- ports: A ports node with endpoint definitions as defined in
>  > +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
>  > +  first port should be the input endpoints, the second one the outputs
>  > +
>  > +DRC
>  > +---
>  > +
>  > +The DRC, found in the latest Allwinner SoCs (A31, A23, A33), allows to
>  > +do some backlight control to enhance the power consumption.
> 
> 'Enhance the power consumption'? That doesn't sound like something you
> would want ;) Presumably it is something to allow you to save power by
> dynamically adjusting LCD backlight and pixel brightness/contrast
> depending on screen content? I believe this is typically called content
> adaptive backlight control:
> 
> https://www.ecnmag.com/article/2010/04/content-adaptive-lcd-backlight-control
> 
> You spell out what DRC and SAT stands for in the driver source code,
> perhaps it also makes sense to do it here?
> 
> Perhaps rewording it to something like this is clearer:
> 
> .. allows to dynamically adjust pixel brightness/contrast based on
> histogram measurements for LCD content adaptive backlight control.

You're right, I changed it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/35bfc0a5/attachment.sig>
