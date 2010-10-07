From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Oct 2010 08:27:41 +0100
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953 and
	ENGcm09472
In-Reply-To: <20101005194659.GY11737@pengutronix.de>
References: <20101005094510.GJ28242@pengutronix.de>
	<1286280012-19809-1-git-send-email-eric@eukrea.com>
	<20101005183308.GX11737@pengutronix.de>
	<4CAB7D0F.9020600@eukrea.com>
	<20101005194659.GY11737@pengutronix.de>
Message-ID: <20101007072741.GA14554@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 05, 2010 at 09:46:59PM +0200, Uwe Kleine-K?nig wrote:
> Hmm, when the caches are off before entering wfi, does that mean that
> all interrupt (and fiq) handlers run with the caches off, too?  That's
> very bad, isn't it?

IRQs are disabled before cpu_idle() calls the calling the chosen idle
function.  If we didn't, we'd miss waking up threads from idle mode.

FIQs aren't covered by the core code though - you have to deal with
any issues there yourself.
