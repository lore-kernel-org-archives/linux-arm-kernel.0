From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 30 Mar 2016 18:12:15 +0200
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5A6HoQ0i7rMm4Ov6AZP6DrE+Vh09NgLtVm0yfDHH62XKw@mail.gmail.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
 <CAOMZO5A6HoQ0i7rMm4Ov6AZP6DrE+Vh09NgLtVm0yfDHH62XKw@mail.gmail.com>
Message-ID: <1459354335.2505.92.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.03.2016, 15:48 -0300 schrieb Fabio Estevam:
> Hi Akshay,
> 
> On Tue, Mar 1, 2016 at 6:41 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> 
> > EB821 doesn't mention the above restriction. My understanding was as long as
> > the clock source you are switching from/to is disabled it should be ok to do
> > so. Maybe someone from Freescale can comment?
> 
> I don't have access to this EB821 document.
> 
> The procedure we have tested is shown here:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.10.17_1.0.1_ga&id=eecbe9a52587cf9eec30132fb9b8a6761f3a1e6d

This patch still describes the switching from top to bottom mux and only
then manipulating the top mux:

	 * The code below switches the parent to the bottom mux first
	 * and then manipulates the top mux. This ensures that no glitch
	 * will enter the divider.

Unfortunately it doesn't detail how this is achieved exactly. I assumed
that it's just that bit 0x4 manipulates the two-port mux that selects
between top and bottom mux and bits 0x3 manipulate the two 4-port muxes
(top and bottom) at the same time, but that was just conjecture.

regards
Philipp
