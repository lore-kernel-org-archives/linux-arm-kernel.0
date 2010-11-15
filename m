From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 15 Nov 2010 16:26:36 +0000
Subject: [Patch v3] Fix audmuxv2 debugfs indexing.
In-Reply-To: <BLU0-SMTP55EFC1F097F339783A2A30B8360@phx.gbl>
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk>
	<87oc9rk6fe.fsf@sympatico.ca>
	<BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
	<20101115153058.GG12986@rakim.wolfsonmicro.main>
	<87oc9qeg75.fsf@sympatico.ca>
	<BLU0-SMTP55EFC1F097F339783A2A30B8360@phx.gbl>
Message-ID: <20101115162636.GH12986@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 11:10:31AM -0500, Bill Pringlemeir wrote:

> Sorry, I should have waited to email.  audmux_port_string() only
> handles six values (not seven).  Also, the audmux.h only has six
> defines for both MX31 and MX27.  There isn't an SSI7 that is being
> reported by the debugfs.  However, a user of the audmux-v2.c code can
> call mxc_audmux_v2_configure_port() with a port value of '6' to
> configure audmux pin set 7 ;-)

SSI7 is an internal network connection thing of some kind.

> The documentation we are working with isn't that helpful.  For the iMx
> 25 pg 13-4, it says there are "Three internal ports", but I can only
> find two ssi devices (with two channels of audio each)...

It's not an SSI port.
