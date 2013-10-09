From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Oct 2013 14:20:04 +0100
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131009130553.GD19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
 <20131009130553.GD19005@pengutronix.de>
Message-ID: <20131009132004.GL21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 03:05:53PM +0200, Markus Pargmann wrote:
> On Tue, Oct 08, 2013 at 11:44:57AM +0100, Mark Brown wrote:

> > Right, but then _STOP will be called without the clock having been
> > successfully enabled so you'll have an unbalanced clk_disable().

> _STOP is only called as long as the error handling is not working
> properly. Otherwise STOP should not be called for a failed START.

I'm not sure what you mean here.  How would the error be handled without
calling _STOP?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/30b374ff/attachment.sig>
