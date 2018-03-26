From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Mar 2018 13:14:54 +0200
Subject: [PATCH v3 0/7] drm/sun4i: Allwinner MIPI-DSI support
In-Reply-To: <CAD6G_RSfiPC2qPjFFukqx6ihzS=_qBOdsP1KnWTP8BJ9Zsekew@mail.gmail.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <CAD6G_RSfiPC2qPjFFukqx6ihzS=_qBOdsP1KnWTP8BJ9Zsekew@mail.gmail.com>
Message-ID: <20180326111454.jqq5dchw27iqhxhe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 23, 2018 at 10:36:35PM +0530, Jagan Teki wrote:
> Hi Maxime,
> 
> On Tue, Mar 6, 2018 at 7:25 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > Here is an preliminary version of the MIPI-DSI support for the Allwinner
> > SoCs.
> >
> > This controller can be found on a number of recent SoCs, such as the
> > A31, A33 or the A64.
> >
> > Given the sparse documentation, there's a number of obscure areas, but
> > the current implementation has been tested with a 4-lanes DSI panel on
> > an A33.
> >
> > The support is a bit rough around the edges at the time, and some artifacts
> > are still shown on the screen for some reasons. Wider testing with
> > different display will hopefully nail those down.
> >
> > Let me know what you think,
> > Maxime
> >
> > Changes from v2:
> >   - Added a ports node under the DSI node
> >   - Changed the huarui panel driver to an ili9881c driver
> >   - Changed the panel vendor to bananapi
> >   - Made the init table static in the panel driver
> >   - Dropped the huarui vendor patch for the DT doc.
> >
> > Changes from v1:
> >   - Rebased on 4.16-rc1
> >   - Constified a few function arguments and structures
> >   - Reworked the DT binding example a bit
> >   - Reworked the panel driver to check for DSI return codes, and use DCS
> >     helpers when possible
> >
> > Maxime Ripard (7):
> >   drm/sun4i: tcon: Add TRI finish interrupt for vblank
> >   dt-bindings: display: Add Allwinner MIPI-DSI bindings
> >   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
> >   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
> >   drm/panel: Add Ilitek ILI9881c panel driver
> >   arm: dts: sun8i: a33: Add the DSI-related nodes
> >   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display
> 
> Any dependencies for this series on linux-next? it is not applying directly.

Last time I rebased on top of 4.16-rc4, there was no dependency but
the regmap patch found in the v2 that got merged. I haven't tried
rebasing on next though.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180326/aecf6fcd/attachment-0001.sig>
