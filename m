From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Oct 2013 10:34:13 +0100
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131008082933.GA19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
Message-ID: <20131008093413.GX21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 10:29:33AM +0200, Markus Pargmann wrote:

> To make proper error handling and only STOP functions that successfully
> started, we have to store the state of each function. The command error
> handling is done in pcm_native.c so we don't have any influence on that.

I meant just unwinding the things done in the trigger call.

> Another possibility is to explicitly allow multiple _STOPs. Then I could
> fix the driver to store the clock state. But I would prefer a generic
> solution.

You're going to have to handle this anyway to be robust - what happens
if it's the clock enable that fails?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/bebd02dd/attachment.sig>
