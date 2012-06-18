From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Jun 2012 12:11:00 +0200
Subject: Dove clock support
In-Reply-To: <4FDEFC6A.7030300@googlemail.com>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
 <4FDEFAE2.7000303@blackshift.org> <4FDEFC6A.7030300@googlemail.com>
Message-ID: <20120618101100.GN4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 12:01:14PM +0200, Sebastian Hesselbarh wrote:
> On 06/18/2012 11:54 AM, Marc Kleine-Budde wrote:
> >>Also ge-phy has to be connected with ge-clk, too. But for dove this is
> >>a clk gate while kirkwood can shut it down somewhere else. I guess it
> >>can be handled like sata/pcie on kirkwood.
> >
> >The PHY is a clock gate so I'm handling it via:
> >>ge = dove_register_gate("ge0", CLOCK_GATING_GBE_BIT | CLOCK_GATING_GIGA_PHY_BIT);
> >So no gate_fn needed.
> 
> There is no fn needed for dove, but kirkwood will need one IIRC.
> Moreover, you could hook-up PHY-gate as a parent of corresponding
> clk-gate and they will be enabled/disabled simultaneously.
> 
> But I'd prefer the driver to take care of clks _and_ PHYs.

That would be nice, but we have to remember that the driver is used
for a number of different Marvell SoC and discreet devices. Only a few
have the ability to turn on/off there clocks and PHYs. So you need to
abstract this in such a way it does not break older chipsets.

> One more: I suggest to clean the clk names of orion platforms,
> they are a mess

Do you have a proposal?

   Thanks
	Andrew
