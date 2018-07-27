From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 27 Jul 2018 10:41:34 +0200
Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
In-Reply-To: <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <20180727084134.f43jwgt2w57vuerm@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 01:51:35AM +0000, Robin Gong wrote:
> 
> 
> > -----Original Message-----
> > From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> > Sent: 2018?7?26? 19:38
> > To: Robin Gong <yibin.gong@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > Mark Brown <broonie@kernel.org>; Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com>
> > Cc: kernel at pengutronix.de; devicetree at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org; linux-clk at vger.kernel.org;
> > linux-kernel at vger.kernel.org; Andrew Morton <akpm@linux-foundation.org>;
> > Liam Girdwood <lgirdwood@gmail.com>; Leonard Crestez
> > <leonard.crestez@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> > Rutland <mark.rutland@arm.com>; Michael Turquette
> > <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>; Fabio
> > Estevam <fabio.estevam@nxp.com>; Russell King <linux@armlinux.org.uk>;
> > dl-linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> > fsl,pmic-stby-poweroff property
> > 
> > Hi,
> > 
> > On 26.07.2018 11:51, Robin Gong wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> > >> Sent: 2018?7?26? 17:22
> > >> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown
> > <broonie@kernel.org>;
> > >> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> > >> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > >> linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org; Andrew
> > >> Morton <akpm@linux-foundation.org>; Liam Girdwood
> > >> <lgirdwood@gmail.com>; Leonard Crestez <leonard.crestez@nxp.com>;
> > Rob
> > >> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > >> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > >> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>;
> > >> Russell King <linux@armlinux.org.uk>; dl-linux-imx
> > >> <linux-imx@nxp.com>; Robin Gong <yibin.gong@nxp.com>; A.s. Dong
> > >> <aisheng.dong@nxp.com>
> > >> Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> > >> fsl,pmic-stby-poweroff property
> > >>
> > >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >> Acked-by: Rob Herring <robh@kernel.org>
> > >> ---
> > >>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> index a45ca67a9d5f..e1308346e00d 100644
> > >> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> @@ -6,6 +6,14 @@ Required properties:
> > >>  - interrupts: Should contain CCM interrupt
> > >>  - #clock-cells: Should be <1>
> > >>
> > >> +Optional properties:
> > >> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
> > >> +signal
> > >> +  on power off.
> > >> +  Use this property if the SoC should be powered off by external
> > >> +power
> > >> +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> > > PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
> > 
> > No. First, it was only one customer specific issue. After some research I found
> > even publicly available boards (for example RioTboard) which has same/similar
> > design. After seeing this in imx6 documentation as valid power off way, I have
> > no doubts - there should be even more devices doin this in the wild.
> Not sure why the customer didn't follow reference design, since PMIC_ON_REQ can
> provide power off/on feature by pressing ONOFF key which connected ONOFF
> pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to power off/on PMIC). The official
> power off/on way (PMIC_ON_REQ) can also power off all power rails of PFUZE except
> snvs as your patch did on PMIC_STBY_REQ.  PMIC_STBY_REQ is used to notify pmic
> switch power mode (PFM/APS) or decrease voltage to save power in kernel suspend,
> not power off....I am not sure if we need this patchset to 'workaround' the board issue.
> > 
> > > Don't understand
> > > why not follow normal board design guide to power off pmic by
> > PMIC_ON_REQ.
> > > How to power on board again then?
> > 
> > Power cycle. Without this patch, power of is not real power off. So, power cycle,
> > is expected behavior for user interaction. On usual PC, reset button will not
> > enable PC as well.
> Your board can't support wakeup by RTC alarm if not use PMIC_ON_REQ to power off.
> Again, why your board not follow the design guide?

Just wild assumption: you haven't read comment provided in patch:
Subject: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set

One of the Freescale recommended sequences for power off with external
PMIC is the following:
...
3.  SoC is programming PMIC for power off when standby is asserted.
4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.

See:
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
page 5083

This patch implements step 4. of this sequence.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/a3fc763c/attachment.sig>
