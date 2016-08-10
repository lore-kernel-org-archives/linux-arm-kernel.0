From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Aug 2016 17:54:32 -0300
Subject: serial: imx: regression triggered by newly introduced DSR irq
 handling
In-Reply-To: <1470398615.1936.22.camel@googlemail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
Message-ID: <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Fri, Aug 5, 2016 at 9:03 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> SION is necessary for pinconfig MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1
> if bit 17 in IOMUXC_GPR_GPR1 is set and bit 13 not.
>
> So that ref_enetpll1 provides a clock not only for the external PHY but
> also for the internal controller.
>
> Using SION is a quirk here, because the silicon doesn't feed the clock
> back to the internal controller automatically.
>
> On the other hand, NXP could argue: You need to add a wire on your PCB
> between ENET1_REF_CLK1 and ENET1_TX_CLK -- but referring to the
> datasheet ENET1_TX_CLK isn't used in RMII config...
>
> So if Fabio or Shawn agrees with my assumption above, I'll add something
> like 27e16501052e5341934d3 "serial: imx: implement DSR irq
> handling for DTE mode".
>
> Okay?

Could you please post your suggestion as a patch or RFC so that we can
understand what your proposal is?

Thanks
