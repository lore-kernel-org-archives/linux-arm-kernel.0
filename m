From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat, 12 Sep 2015 13:07:52 +0100
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA
 DT binding documentation
In-Reply-To: <51503956.PMFrWKUjxX@wuerfel>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-2-git-send-email-peter.griffin@linaro.org>
 <51503956.PMFrWKUjxX@wuerfel>
Message-ID: <20150912120752.GA19897@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, 11 Sep 2015, Arnd Bergmann wrote:

> On Friday 11 September 2015 15:14:23 Peter Griffin wrote:
> > +- st,fdma-id	: Must contain fdma controller number
> 
> What for?

It is used by the driver to generate a unique firmware name.
Basically we need to know which controller instance we
are as each controller has a different firmware which needs
to be loaded.

Rob did say that having a index type property is undesirable
over here, see my reply at the bottom
http://www.spinics.net/lists/devicetree/msg92529.html.

However I can't think of any other useful properties we could add
to derive this information.

> > +Example:
> > +
> > +	fdma1: fdma-app at 8e40000 {
> 
> The name should be "dma-controller", not "fdma-app".

Ok will fix in v3

> 
> > +Example:
> > +
> > +	snd_uni_player2: snd-uni-player at 2 {
> > +		compatible = "st,snd_uni_player";
> 
> Maybe change the compatible string to "st,snd-uni-player"?

Just checking the upstream driver which got merged for v4.3
and the compatible has changed to "st,sti-uni-player" so I
can update the DT doc example to use this in v3.

> 
> The string you use here would not be acceptable for a binding.

Presumably it is the use of "underscores" in the compatible which
is not allowed? Is that correct?

regards,

Peter.
