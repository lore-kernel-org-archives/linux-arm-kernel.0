From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 19 Apr 2011 08:53:40 +0800
Subject: [PATCH 03/10] clk: Make NULL a valid clock again
In-Reply-To: <1302894495-6879-4-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1303174420.2801.18.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> NULL used to be a valid clock. This patch makes the common struct
> clk stuff work with this. Instead of crashing we return sane default
> values for this dummy clock, that is: can always be prepared, enabled,
> rate unkown and no set rate.

Although I'm not totally averse to this change, I've been trying to
avoid allowing NULL clocks - it seems to be a little 'messy' to allows
clocks that don't have any possible operations on them, and could hide
error cases where clock pointers have not been correctly initialised.

However, I understand that this may be required for flexibility between
machines, and in that case would make sense. Is that what you're
intending this for?

Cheers,


Jeremy
