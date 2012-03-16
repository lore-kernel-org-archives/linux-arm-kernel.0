From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Mar 2012 19:21:12 +0000
Subject: [alsa-devel] [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <20120316111814.GA7860@S2101-09.ap.freescale.net>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
 <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
 <20120316111814.GA7860@S2101-09.ap.freescale.net>
Message-ID: <20120316192110.GH3158@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 07:18:18PM +0800, Shawn Guo wrote:

> Maybe having "fsl,imx-audio-xxx" for machine drivers backed by SSI,
> and "fsl,imx-esai-audio-xxx" for the ones backed by ESAI?

Alternatively if the SSI and ESAI devices are compatible enough at the
ASoC API level (or can be identified by the driver just by looking at
the DAI that's referenced without too much pain) the CPU DAI could just
be linked to either type of DAI (probably with a more generic name for
the property).

But either way works fine, and obviously you're going to end up with
more complex systems which use a completely custom binding anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/7c12c8c2/attachment.sig>
