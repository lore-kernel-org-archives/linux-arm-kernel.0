From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 13 Jun 2016 13:03:18 +0200
Subject: [PATCH 2/2] ARM: dts: imx6: tag boards that have the HW
 workaround for ERR006687
In-Reply-To: <20160607124650.1e69c658@jclayton-pc>
References: <1464794983-31484-1-git-send-email-l.stach@pengutronix.de>
 <1464794983-31484-3-git-send-email-l.stach@pengutronix.de>
 <20160601161729.GB19428@n2100.arm.linux.org.uk>
 <1464855906.9501.1.camel@pengutronix.de>
 <20160607124650.1e69c658@jclayton-pc>
Message-ID: <1465815798.2313.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 07.06.2016, 12:46 -0700 schrieb Joshua Clayton:
> On Thu, 02 Jun 2016 10:25:06 +0200
> Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > Am Mittwoch, den 01.06.2016, 17:17 +0100 schrieb Russell King - ARM
> > Linux:
> > > On Wed, Jun 01, 2016 at 05:29:43PM +0200, Lucas Stach wrote:  
> > > > @@ -97,6 +97,7 @@
> > > >  	phy-reset-gpios = <&gpio3 31 0>;
> > > >  	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> > > >  			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> > > > +	fsl,err006687-war-present;  
> > > 
> 
> Why can't we just have the quirk detect the interrupts-extended
> property, which is not present on boards without the workaround.
> Wouldn't that be better? No dts change needed.
> 
I pondered that idea too, but have gone with the solution presented in
this patch series as it's more explicit and - with far more weight to it
- does not require the driver to touch DT properties that are outside of
its domain of responsibility. The "interrupts-extended" properties are
not meant to be parsed by the driver, but rather the IRQ subsystem.

Regards,
Lucas
