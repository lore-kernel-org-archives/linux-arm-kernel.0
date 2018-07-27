From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 27 Jul 2018 10:30:11 +0200
Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
In-Reply-To: <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <1532680211.32306.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Am Freitag, den 27.07.2018, 01:51 +0000 schrieb Robin Gong:
[...]
> > > > ---
> > > > ?Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
> > > > ?1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > index a45ca67a9d5f..e1308346e00d 100644
> > > > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > @@ -6,6 +6,14 @@ Required properties:
> > > > ?- interrupts: Should contain CCM interrupt
> > > > ?- #clock-cells: Should be <1>
> > > > 
> > > > +Optional properties:
> > > > +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
> > > > +signal
> > > > +??on power off.
> > > > +??Use this property if the SoC should be powered off by external
> > > > +power
> > > > +??management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> > > 
> > > PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
> > 
> > No. First, it was only one customer specific issue. After some research I found
> > even publicly available boards (for example RioTboard) which has same/similar
> > design. After seeing this in imx6 documentation as valid power off way, I have
> > no doubts - there should be even more devices doin this in the wild.
> 
> Not sure why the customer didn't follow reference design, since PMIC_ON_REQ can
> provide power off/on feature by pressing ONOFF key which connected ONOFF
> pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to power off/on PMIC). The official
> power off/on way (PMIC_ON_REQ) can also power off all power rails of PFUZE except
> snvs as your patch did on PMIC_STBY_REQ.??PMIC_STBY_REQ is used to notify pmic
> switch power mode (PFM/APS) or decrease voltage to save power in kernel suspend,
> not power off....I am not sure if we need this patchset to 'workaround' the board issue.
> 
Not all boards follow the reference design, that's a fact of life.

Please look at the i.MX6Q reference manual. The sequence implemented in
this patchset can be found as a valid way to power off the system in
"60.4.3 Power mode transitions" "Normal ON to OFF with external PMIC",
so there is hardly any way to argue that this is a board specific
quirk. This is one of the Freescale/NXP recommended sequences to turn
off the system.

Regards,
Lucas
