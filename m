From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Mar 2018 10:52:04 +0100
Subject: [PATCH v2 08/10] drm/panel: Add Huarui LHR050H41 panel driver
In-Reply-To: <CAGb2v66c-KntNqkb0=qyP2JCafUOcPuh1o_VqeGencMXEuEfMA@mail.gmail.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
 <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66c-KntNqkb0=qyP2JCafUOcPuh1o_VqeGencMXEuEfMA@mail.gmail.com>
Message-ID: <20180302095204.jskwptipqa6x42gn@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 21, 2018 at 11:36:10PM +0800, Chen-Yu Tsai wrote:
> On Wed, Feb 21, 2018 at 5:20 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic. Add a
> > driver for it.
> 
> So I distinctly remember questioning the vendor name the first time.
> I would just use Bananapi as the vendor name instead.

Ack.

> > +config DRM_PANEL_HUARUI_LHR050H41
> > +       tristate "Huarui LHR050H41 panel"
> > +       depends on OF
> > +       depends on DRM_MIPI_DSI
> > +       depends on BACKLIGHT_CLASS_DEVICE
> > +       help
> > +         Say Y if you want to enable support for the Huarui Lighting
> > +         LHR05041 DSI panel. The panel has a 1280x720 resolution.
> > +
> 
> And it seems this panel is driven by an ILI9881C from Ilitek. So
> maybe you could make the panel driver more like the IL9322, as in
> having common code for the driver IC, then a data structure tied
> to actual panel compatible strings to handle any quirks.
> 
> The datasheet can be found simply by googling the part ID, or here:
> 
>    http://en.startek-lcd.com/res/starteklcden/pdres/201706/20170617115241070.pdf
> 
> This should help with the init command sequence.
> 
> I also found this:
> 
> http://www.ampdisplay.com/documents/pdf/AM-7201280ETZQW-00H.pdf
> 
> which might or might not be the same panel.
> 
> Now the IL9332 driver simply uses the device model (Dlink DIR-685)
> as part of the compatible string.

I guess we can create an ili9881c driver then, with the lhr050h41
compatible. I'm not sure there's much more we can do at this point,
since in order to know the set of quirks to associate to each
compatible, we'd need to have a second panel.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/5e9a919e/attachment.sig>
