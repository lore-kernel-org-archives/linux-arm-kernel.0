From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 10 Oct 2013 10:40:40 +0200
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131009145917.GN21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
 <20131009130553.GD19005@pengutronix.de>
 <20131009132004.GL21581@sirena.org.uk>
 <20131009141242.GE19005@pengutronix.de>
 <20131009145917.GN21581@sirena.org.uk>
Message-ID: <20131010084040.GG19005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 03:59:17PM +0100, Mark Brown wrote:
> On Wed, Oct 09, 2013 at 04:12:42PM +0200, Markus Pargmann wrote:
> > On Wed, Oct 09, 2013 at 02:20:04PM +0100, Mark Brown wrote:
> 
> > > I'm not sure what you mean here.  How would the error be handled without
> > > calling _STOP?
> 
> > The START error should be handled in mxs_saif and there shouldn't be a
> > _STOP call for mxs_saif_trigger afterwards to handle the failed START.
> 
> How would the framework know that the error has been handled - what
> tells it that the error returned is for an error that has been handled
> as opposed to an error that has not been handled?

I finally understand what you mean. Yes, RFCv1 fixes the behavior for
the components without _START failures. But it doesn't fix it for the
failing component.

For mxs-saif, we still have to store if the last START failed to handle
the following STOP correctly which is not very different from handling
double STOPs correctly. I don't have an idea how to fix RFCv1 without
using some state as in RFCv2. Perhaps we should simply fix it in
mxs-saif and other drivers then?

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
