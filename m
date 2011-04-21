From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 21:48:28 +0200 (CEST)
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104212146400.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr 2011, Sascha Hauer wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> + * @get:	Called by the core clock code when a device driver acquires a
> + *		clock via clk_get(). Optional.
> + *
> + * @put:	Called by the core clock code when a devices driver releases a
> + *		clock via clk_put(). Optional.

These callbacks are completely pointless. There are only two non empty
implementations in tree:

One does a try_module_get(clk->owner), which should be done in generic
code. The other does special clock enabling magic which wants to go to
clk->prepare().

Thanks,

	tglx
