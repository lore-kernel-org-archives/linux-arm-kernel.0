From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Oct 2013 15:59:17 +0100
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131009141242.GE19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
 <20131009130553.GD19005@pengutronix.de>
 <20131009132004.GL21581@sirena.org.uk>
 <20131009141242.GE19005@pengutronix.de>
Message-ID: <20131009145917.GN21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 04:12:42PM +0200, Markus Pargmann wrote:
> On Wed, Oct 09, 2013 at 02:20:04PM +0100, Mark Brown wrote:

> > I'm not sure what you mean here.  How would the error be handled without
> > calling _STOP?

> The START error should be handled in mxs_saif and there shouldn't be a
> _STOP call for mxs_saif_trigger afterwards to handle the failed START.

How would the framework know that the error has been handled - what
tells it that the error returned is for an error that has been handled
as opposed to an error that has not been handled?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/b6950399/attachment.sig>
