From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 14 Aug 2013 12:51:57 +0800
Subject: [PATCH 2/2] arm: mach-imx: anatop: add two APIs for USB driver
In-Reply-To: <20130814063236.GA31141@S2101-09.ap.freescale.net>
References: <1376292414-22922-1-git-send-email-peter.chen@freescale.com>
 <1376292414-22922-2-git-send-email-peter.chen@freescale.com>
 <20130814034754.GD16915@S2101-09.ap.freescale.net>
 <20130814035005.GA30404@shlinux1.ap.freescale.net>
 <20130814063236.GA31141@S2101-09.ap.freescale.net>
Message-ID: <20130814045154.GA29959@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 02:32:38PM +0800, Shawn Guo wrote:
> On Wed, Aug 14, 2013 at 11:50:07AM +0800, Peter Chen wrote:
> > > > +void imx_anatop_usb1_disconnect_line(bool enable)
> > > > +{
> > > > +	if (enable)
> > > > +		regmap_write(anatop, ANADIG_USB1_LOOPBACK,
> > > > +			BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
> > > > +				BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
> > > > +	else
> > > > +		regmap_write(anatop, ANADIG_USB1_LOOPBACK, 0);
> > > > +}
> > > > +EXPORT_SYMBOL(imx_anatop_usb1_disconnect_line);
> > > > +
> > > > +void imx_anatop_set_stop_mode_config(bool enable)
> > > > +{
> > > > +	regmap_write(anatop, ANADIG_ANA_MISC0 +
> > > > +		(enable ? REG_SET : REG_CLR),
> > > > +			BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG);
> > > > +}
> > > > +EXPORT_SYMBOL(imx_anatop_set_stop_mode_config);
> > > > +
> > > 
> > > Where do you want to call these two functions from?
> > > 
> > 
> > From USB driver, the usb driver is possible built as module.
> 
> I do not think it's appropriate have device driver directly call into
> platform level functions.

Will do it like thermal and regulator driver, please forget it.

-- 

Best Regards,
Peter Chen
