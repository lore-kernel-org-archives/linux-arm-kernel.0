From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 11 Sep 2014 08:40:16 +0200
Subject: [alsa-devel] [PATCH 2/5] ASoC: fsl: add imx-tlv320aic3x machine
 driver
In-Reply-To: <CAGoOwPSpkNy6uNVAjG2HgiHHscKZjL5wgVrkyGwWCmyU7x+gWg@mail.gmail.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <20140910142740.GC16489@pengutronix.de>
 <CAGoOwPSpkNy6uNVAjG2HgiHHscKZjL5wgVrkyGwWCmyU7x+gWg@mail.gmail.com>
Message-ID: <20140911064016.GE16489@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 11:14:15AM -0700, Nicolin Chen wrote:
> On Wed, Sep 10, 2014 at 7:27 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> > Hi,
> >
> > On Wed, Sep 10, 2014 at 04:46:46PM +0300, Dmitry Lavnikevich wrote:
> >> This is driver for i.MX6 boards with tlv320aic3x audio codecs.
> >>
> >> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> >> ---
> >>  .../bindings/sound/fsl,imx-audio-tlv320aic3x.txt   |  27 ++++
> >>  sound/soc/fsl/Kconfig                              |  13 ++
> >>  sound/soc/fsl/Makefile                             |   2 +
> >>  sound/soc/fsl/imx-tlv320aic3x.c                    | 177 +++++++++++++++++++++
> >>  4 files changed, 219 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-tlv320aic3x.txt
> >>  create mode 100644 sound/soc/fsl/imx-tlv320aic3x.c
> >
> > Is it possible to use the simple-card
> > (Documentation/devicetree/bindings/sound/simple-card.txt) instead of
> > adding a new audio card driver? There are also DT bindings for the imx
> > audiomultiplexer (imx-audmux.txt).
> 
> I don't know why my mutt doesn't display this mail.
> 
> Anyway, if Simple Card supports audmux, yes, it's also a good idea.

Simple Card doesn't support it. But there are DT bindings for the audmux
device node which allow the definition of a default multiplexer setup.
That configuration is applied in the probe() function of the audmux driver.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/6d901b31/attachment.sig>
