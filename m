From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Dec 2010 20:05:09 +0800
Subject: [PATCH 07/10] ARM: mx28: add the second fec device registration
In-Reply-To: <20101229105001.GW14221@pengutronix.de>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-8-git-send-email-shawn.guo@freescale.com>
	<20101229105001.GW14221@pengutronix.de>
Message-ID: <20101229120508.GH19347@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Dec 29, 2010 at 11:50:01AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> > -static const struct fec_platform_data mx28_fec_pdata __initconst = {
> > -	.phy = PHY_INTERFACE_MODE_RMII,
> > +static struct fec_platform_data mx28_fec_pdata[] = {
> > +	{
> > +		/* fec0 */
> > +		.phy = PHY_INTERFACE_MODE_RMII,
> > +	}, {
> > +		/* fec1 */
> > +		.phy = PHY_INTERFACE_MODE_RMII,
> > +	},
> >  };
> I think there is no need to duplicate the platform_data as mx28_add_fec
> makes a copy anyhow.  Did you remove __initconst and const on purpose?
> 
The mac field is different for fec0 and fec1 and needs to be
assigned in mx28evk_fec_get_mac.

-- 
Regards,
Shawn
