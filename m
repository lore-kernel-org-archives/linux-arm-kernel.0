From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 19 Jun 2011 09:02:38 +0200
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <20110618161934.GH8195@ponder.secretlab.ca>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
Message-ID: <20110619070238.GD1632@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2011 at 10:19:34AM -0600, Grant Likely wrote:
> On Sat, Jun 18, 2011 at 11:19:12PM +0800, Shawn Guo wrote:
> > It adds device tree data parsing support for imx tty/serial driver.
> > 
> > Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> > Signed-off-by: Jason Liu <jason.hui@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../bindings/tty/serial/fsl-imx-uart.txt           |   21 +++++
> >  drivers/tty/serial/imx.c                           |   81 +++++++++++++++++---
> >  2 files changed, 92 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > new file mode 100644
> > index 0000000..7648e17
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > @@ -0,0 +1,21 @@
> > +* Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
> > +
> > +Required properties:
> > +- compatible : should be "fsl,<soc>-uart", "fsl,imx-uart"
> 
> I'd make this "fsl,<soc>-uart", "fsl,imx51-uart"
> 
> It's better to anchor these things on real silicon, or a real ip block
> specification rather than something pseudo-generic.  Subsequent chips,
> like the imx53, should simply claim compatibility with the older
> fsl,imx51-uart.
> 
> (in essence, "fsl,imx51-uart" becomes the generic string without the
> downside of having no obvious recourse when new silicon shows up that
> is an imx part, but isn't compatible with the imx51 uart.

Shouldn't that be the oldest SoC this core showed up? It might be an academic
question, but it would look a bit funny if mx27 got dt-support and would have a
imx51-uart? The first imx to have this core is the mx1. (Although there are
some cpu_is_mx1() calls used in the driver, but they are still available, or?)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110619/14bcddb8/attachment.sig>
