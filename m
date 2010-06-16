From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 16 Jun 2010 07:35:19 +0200
Subject: [PATCH 2/2] ehci-mxc: bail out on transceiver problems
In-Reply-To: <20100616014458.GA30484@pengutronix.de>
References: <1276598063-3956-1-git-send-email-w.sang@pengutronix.de>
	<1276598063-3956-2-git-send-email-w.sang@pengutronix.de>
	<20100615104342.GE17833@buzzloop.caiaq.de>
	<20100616014458.GA30484@pengutronix.de>
Message-ID: <20100616053519.GT17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 16, 2010 at 03:44:58AM +0200, Wolfram Sang wrote:
> On Tue, Jun 15, 2010 at 12:43:42PM +0200, Daniel Mack wrote:
> > On Tue, Jun 15, 2010 at 12:34:23PM +0200, Wolfram Sang wrote:
> > > The old code registered the hcd even if there were no transceivers
> > > detected, leading to oopses like this if we try to probe a non-existant
> > > ULPI:
> > 
> > Hmm. I'm aware that there was a missing bail in this function, but
> > actually, I had hardware which didn't properly detect the ULPI chip but
> > still worked fine. There has been quite some discussion here about that,
> > and eventually I decided to not make this a hard error as it didn't
> > really harm.
> 
> Hmm, so, do you think this patch is stable-material after all?

Hard to say. It might break existing board support, which would be a
regression. OTOH, it fixes an Oops. Don't know really ...

Daniel
