From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 09:27:13 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F621D09.2080806@freescale.com>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
 <4F621D09.2080806@freescale.com>
Message-ID: <20120316012711.GD6065@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:47:05AM -0500, Timur Tabi wrote:
> Shawn Guo wrote:
> > sound {
> >       compatible = "fsl,imx51-babbage-sgtl5000",
> >                    "fsl,imx-audio-sgtl5000";
> >       model = "imx51-babbage-sgtl5000";
> >       ssi-controller = <&ssi1, &ssi2>;
> >       audio-codec = <&sgtl5000_1, &sgtl5000_2>;
> >       mux-int-port = <1>;
> >       mux-ext-port = <3>;
> > };
> 
> Based on Mark's other email, I would rather see this:
> 
> sound1 {
>       compatible = "fsl,imx51-babbage-sgtl5000",
>                    "fsl,imx-audio-sgtl5000";
>       model = "imx51-babbage-sgtl5000";
>       ssi-controller = <&ssi1>;
>       audio-codec = <&sgtl5000_1>;
>       mux-int-port = <1>;
>       mux-ext-port = <3>;
> };
> 
> sound2 {
>       compatible = "fsl,imx51-babbage-sgtl5000",
>                    "fsl,imx-audio-sgtl5000";
>       model = "imx51-babbage-sgtl5000";
>       ssi-controller = <&ssi2>;
>       audio-codec = <&sgtl5000_2>;
>       mux-int-port = <1>;
>       mux-ext-port = <3>;
> };
> 
> (ignoring for the moment that I have no idea what the mux-xxx-port values
> in sound2 should be)
> 
> This makes it clear that ssi1 connects only to sgtl5000_1.
> 
> If you're okay with this, then please update the documentation accordingly.
> 
Hmm, Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
is the binding document specifically for imx-sgtl5000 driver rather
than for all fsl_ssi based machine drivers.  Since I have never seen
and doubt will ever see the setup that two SSIs connect to two
sgtl5000 codecs on any imx board, I do not see much point to update
the documentation for that.

If this is indeed a practical setup for PowerPC, it can be documented
in the binding for PowerPC machine driver when there is future PowerPC
machine drivers adopting the new binding.

-- 
Regards,
Shawn
