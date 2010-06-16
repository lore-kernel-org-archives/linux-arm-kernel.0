From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Jun 2010 03:44:58 +0200
Subject: [PATCH 2/2] ehci-mxc: bail out on transceiver problems
In-Reply-To: <20100615104342.GE17833@buzzloop.caiaq.de>
References: <1276598063-3956-1-git-send-email-w.sang@pengutronix.de>
	<1276598063-3956-2-git-send-email-w.sang@pengutronix.de>
	<20100615104342.GE17833@buzzloop.caiaq.de>
Message-ID: <20100616014458.GA30484@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 12:43:42PM +0200, Daniel Mack wrote:
> On Tue, Jun 15, 2010 at 12:34:23PM +0200, Wolfram Sang wrote:
> > The old code registered the hcd even if there were no transceivers
> > detected, leading to oopses like this if we try to probe a non-existant
> > ULPI:
> 
> Hmm. I'm aware that there was a missing bail in this function, but
> actually, I had hardware which didn't properly detect the ULPI chip but
> still worked fine. There has been quite some discussion here about that,
> and eventually I decided to not make this a hard error as it didn't
> really harm.

Hmm, so, do you think this patch is stable-material after all?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100616/bd0e517d/attachment.sig>
