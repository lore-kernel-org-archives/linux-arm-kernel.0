From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 19:18:18 +0800
Subject: [alsa-devel] [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
 <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
Message-ID: <20120316111814.GA7860@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 06:16:13AM -0400, Trent Piepho wrote:
> On Fri, Mar 16, 2012 at 4:56 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > +Required properties:
> > +- compatible : "fsl,imx-audio-sgtl5000"
> > +- model : The user-visible name of this sound complex
> > +- ssi-controller : The phandle of the i.MX SSI controller
> > +- audio-codec : The phandle of the SGTL5000 audio codec
> > +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
> > +- mux-ext-port : The external port of the i.MX audio muxer
> > +
> > +Note: The AUDMUX port numbering should start at 1, which is consistent with
> > +hardware manual.
> > +
> > +Example:
> > +
> > +sound {
> > + ? ? ? compatible = "fsl,imx51-babbage-sgtl5000",
> > + ? ? ? ? ? ? ? ? ? ?"fsl,imx-audio-sgtl5000";
> > + ? ? ? model = "imx51-babbage-sgtl5000";
> > + ? ? ? ssi-controller = <&ssi1>;
> > + ? ? ? audio-codec = <&sgtl5000>;
> > + ? ? ? mux-int-port = <1>;
> > + ? ? ? mux-ext-port = <3>;
> > +};
> 
> What would the device node look like for the ESAI controller?  I've
> got a board here based on an iMX53 with two of three SSI controllers
> and the ESAI controller in use.  It used the nullcodec codec driver
> for SSI and ESAI.  The ESAI driver was since replaced with an entirely
> new custom driver that doesn't use ASoC at all.  But ignoring that
> detail, what would the sound node(s) look like for some hardware that
> isn't so simple?  It seems like there would be three sound nodes, but
> what would compatible and model be set to?  I'm having a hard time
> seeing how "fsl,imx-audio-sgtl5000" would be changed into something
> for either SSI or ESAI.

Maybe having "fsl,imx-audio-xxx" for machine drivers backed by SSI,
and "fsl,imx-esai-audio-xxx" for the ones backed by ESAI?

-- 
Regards,
Shawn
