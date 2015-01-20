From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 16:03:39 +0800
Subject: [PATCH 1/2] ARM: imx6sx-sdb: change default board as reva board
In-Reply-To: <BN1PR0301MB062873E37C225DD38B2BCE3CFF4B0@BN1PR0301MB0628.namprd03.prod.outlook.com>
References: <1421220998-3491-1-git-send-email-peter.chen@freescale.com>
 <1421220998-3491-2-git-send-email-peter.chen@freescale.com>
 <20150120073527.GT2766@dragon> <20150120063016.GD13645@shlinux2>
 <BN1PR0301MB062873E37C225DD38B2BCE3CFF4B0@BN1PR0301MB0628.namprd03.prod.outlook.com>
Message-ID: <20150120080338.GW2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 07:51:31AM +0000, Anson.Huang at freescale.com wrote:
> > > > +&cpu0 {
> > > > +	operating-points = <
> > > > +		/* kHz    uV */
> > > > +		996000  1250000
> > > > +		792000  1175000
> > > > +		396000  1075000
> > > > +	>;
> > > > +	fsl,soc-operating-points = <
> > > > +		/* ARM kHz  SOC uV */
> > > > +		996000      1175000
> > > > +		792000      1175000
> > > > +		396000      1175000
> > > > +	>;
> > >
> > > I'm wondering why different revision of the board require a different
> > > OPP settings.
> > >
> > 
> > Anson, do you know the reason?
> 
> As i.MX6SX SDB Rev-B board uses PFuse 200 which has only one power supply for both
> VDDARM_IN and VDDSOC_IN, so it needs VDDARM_IN equal VDDSOC_IN, currently
> we set Rev-B board as default in imx6sx.dtsi, which uses same voltage for both
> VDDARM_IN and VDDSOC_IN.The Rev-A board uses PFuze 100 which has separate power
> supply for VDDARM_IN and VDDSOC_IN, so it can use different voltage on VDDARM_IN
> and VDDSOC_IN according to datasheet.

Thanks for the clarification, Anson.

Peter,

OPP is a CPU characteristic defined by data sheet, so we should define
OPP according to data sheet in imx6sx.dtsi, and only overwrite the
property in Rev-B dts per board/PMIC quirk.

Also, please put the rationale why we need OPP quick on Rev-B into
commit log.

Shawn
