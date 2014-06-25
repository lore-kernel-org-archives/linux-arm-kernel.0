From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 11:46:28 +0200
Subject: [PATCH v14 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <20140625084327.GD32514@n2100.arm.linux.org.uk>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-4-git-send-email-denis@eukrea.com>
 <20140625044845.GK5918@pengutronix.de>
 <20140625084327.GD32514@n2100.arm.linux.org.uk>
Message-ID: <20140625094628.GS15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 09:43:27AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 25, 2014 at 06:48:45AM +0200, Sascha Hauer wrote:
> > On Mon, Jun 16, 2014 at 12:11:18PM +0200, Denis Carikli wrote:
> > > +
> > >  /*
> > >   * Bitfield of Display Interface signal polarities.
> > >   */
> > > @@ -37,7 +43,7 @@ struct ipu_di_signal_cfg {
> > >  	unsigned clksel_en:1;
> > >  	unsigned clkidle_en:1;
> > >  	unsigned data_pol:1;	/* true = inverted */
> > > -	unsigned clk_pol:1;	/* true = rising edge */
> > > +	unsigned clk_pol:1;
> > >  	unsigned enable_pol:1;
> > >  	unsigned Hsync_pol:1;	/* true = active high */
> > >  	unsigned Vsync_pol:1;
> > 
> > ...can we rename the flags to more meaningful names instead?
> > 
> > 	unsigned clk_pol_rising_edge:1;
> > 	unsigned enable_pol_high:1;
> > 	unsigned hsync_active_high:1;
> > 	unsigned vsync_active_high:1;
> 
> Now look at patch 7, where these become tri-state:
> - don't change
> - rising edge/active high
> - falling edge/active low
> 
> So your suggestion is not a good idea.

Hm, you're right.

Still I think we should add a prefix to make the context of the flags
clear.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
