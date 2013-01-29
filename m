From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Jan 2013 14:38:59 -0200
Subject: [BUG] i.MX25: soft lockups/freezes while getnstimeofday
In-Reply-To: <20130129161230.GA3128@pengutronix.de>
References: <20130129161230.GA3128@pengutronix.de>
Message-ID: <CAOMZO5DLDikzF5LMWQLw_65ADSy2-aydvhTbpFhbBV_DwS9sCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On Tue, Jan 29, 2013 at 2:12 PM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:

> The board itself supposedly worked up until v3.4.
>
> The mxc-timer is set up to use ipg_clk_highfreq with a per5_div set to 2,
> therefore it is clocked with 120MHz. I tried to set the per5_div to 4 to have
> a 60MHz clock, but this didn't change anything.
> On the other hand, I tried parenting the ipg_clk to the per5_clk to get a
> 66MHz clock. This seems to be working fine, but I only have it running for 4h now.

Can you dump the clock tree in 3.4 and 3.7.2, so that we can compare them?

Just looked at the FSL BSP and they have the following:

	/* GPT clock must be derived from AHB clock */
	clk_set_rate(&per_clk[5], ahb_clk.rate / 10);

Regards,

Fabio Estevam
