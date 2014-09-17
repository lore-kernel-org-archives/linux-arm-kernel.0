From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Sep 2014 09:24:37 +0200
Subject: [PATCH v2 1/3] ARM: dts: imx6: add pm_power_off support for
 i.mx6 chips
In-Reply-To: <20140917071736.GA5545@Robin-OptiPlex-780>
References: <1410511739-31122-1-git-send-email-b38343@freescale.com>
 <1410511739-31122-2-git-send-email-b38343@freescale.com>
 <20140917021044.GD4796@dragon>
 <20140917034514.GF27452@Robin-OptiPlex-780>
 <20140917060649.GJ4992@pengutronix.de>
 <20140917071736.GA5545@Robin-OptiPlex-780>
Message-ID: <20140917072437.GP4992@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 03:17:38PM +0800, Robin Gong wrote:
> On Wed, Sep 17, 2014 at 08:06:49AM +0200, Sascha Hauer wrote:
> > On Wed, Sep 17, 2014 at 11:45:15AM +0800, Robin Gong wrote:
> > > On Wed, Sep 17, 2014 at 10:10:45AM +0800, Shawn Guo wrote:
> > > > On Fri, Sep 12, 2014 at 04:48:57PM +0800, Robin Gong wrote:
> > > > > All chips of i.mx6 can be powered off by programming SNVS.
> > > > > For example :
> > > > > On i.mx6q-sabresd board, PMIC_ON_REQ connect with external
> > > > > pmic ON/OFF pin, that will cause the whole PMIC powered off
> > > > > except VSNVS. And system can restart once PMIC_ON_REQ goes
> > > > > high by push POWRER key.
> > > > 
> > > > What's the behavior for those boards on which PMIC_ON_REQ isn't
> > > > connected to anywhere?
> > > >
> > > System can't be powered off if not connect PMIC_ON_REQ. Although all of our
> > > reference design for i.mx6 chips are connecting  PMIC_ON_REQ with external
> > > PMIC, we need consider others may not use external PMIC. I'll add the info
> > > into commit log or Kconfig.
> > 
> > You should add the information to the dtsi file in form of a
> > status = "disabled" property so that boards that actually have the
> > feature can enable it.
> > 
> > Sascha
> Hi Sacha, but that's  SOC level feature and it's harmless even if others don't
> want to use this pin to control external PMIC.

Harmless? If a pm_power_off hook is registered I expect it to work, but
it doesn't work when my board does not have the connection between the
PMIC and the SoC. Even worse, if my board has some custom power of
method you overwrite my method in the snvs poweroff driver with a method
that does not work on my board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
