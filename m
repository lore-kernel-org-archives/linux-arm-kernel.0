From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Mar 2013 12:37:00 +0000
Subject: [PATCH 2/2] ARM: clk: imx35 sound admux_gate bugfix
In-Reply-To: <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
 <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
 <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
Message-ID: <20130327123659.GT18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 12:57:00PM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 27.03.2013, 12:22 +0100 schrieb Markus Pargmann:
> > imx-ssi needs admux_gate clock to work on imx35. This patch registers
> > this clock and enables it in the imx-ssi driver.

> I have no idea what the admux_gate really is, but the ssi driver doesn't
> seem like the right place. Isn't this more closely related to the
> imx-audmux.c driver?

This is a patch to the ASoC driver?  I just ignored it since it said it
was an ARM patch...  Anyway, what I'd expect should be happening here is
that the clock API walks up the tree enabling supply clocks - that would
mean that either that code isn't there or there's a missing parent child
relationship in the data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/4ed8b1f3/attachment.sig>
