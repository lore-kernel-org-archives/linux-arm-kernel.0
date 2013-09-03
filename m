From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 3 Sep 2013 08:58:32 +0200
Subject: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F827F7C59@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
 <20130830174909.GF30088@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827F785F@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130902085630.GS30088@pengutronix.de>
 <1DD289F6464F0949A2FCA5AA6DC23F827F7C59@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <20130903065832.GB30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 04:17:09AM +0000, Xiubo Li-B47053 wrote:
> > Subject: Re: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
> > 
> > You simply don't need the available field. You don't need to track
> > whether they are available. If a user enables a pwm which is not routed
> > out of the SoC (disabled in the iomux) simply nothing will happen except
> > for a slightly increased power consumption.
> > 
> If the there is not need to explicitly specify the channels are
> available or not, so there is no doubt that the 'available' field will
> be dropt.  Why I added this here is because that the 4th and 5th
> channels' pinctrls are used as UART TX and RX as I have mentioned
> before, so here if you configure these two pinctrls, the UART TX and
> RX will be polluted, there maybe some other cases like this.

If you misconfigure your iomux then usually unexptected things happen.
That is not the problem of the PWM driver, but the problem of the one
writing the devicetree. The kernel will print a message for conflicting
iomux settings. That should be hint enough to fix it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
