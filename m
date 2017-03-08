From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 08 Mar 2017 18:32:37 +0100
Subject: [PATCH v2] ARM: imx6: add ZII RDU2 boards
In-Reply-To: <20170308171445.GG19934@x250>
References: <20170210153928.30588-1-l.stach@pengutronix.de>
 <20170308171445.GG19934@x250>
Message-ID: <1488994357.9636.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 08.03.2017, 18:14 +0100 schrieb Shawn Guo:
> On Fri, Feb 10, 2017 at 04:39:28PM +0100, Lucas Stach wrote:
> > This adds support for the Zodiac Inflight Innovations RDU2 board,
> > which has both a Quad and a QuadPlus variant.
> > 
> > The board supports different panels, with the bootloader patching
> > in the correct compatible, depending on the hardware configuration.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Tested-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> 
[...]
>   +	panel {
> > +		power-supply = <&reg_3p3v_display>;
> > +		status = "disabled";
> 
> Why does it get disabled?

The LVDS panel node as well as several other display related nodes are
disabled by default, as this is a generic DT with multiple possible
display configurations. The bootloader (Barebox) knows about the
specific connected display and will enable the correct nodes, as well
as patch in the correct compatible for the panel.

> 
> > +
> > +		port {
> > +			panel_in: endpoint {
> > +				remote-endpoint = <&lvds0_out>;
> > +			};
> > +		};
> > +	};
[...]

Regards,
Lucas
