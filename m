From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 10 Sep 2018 16:16:03 +0200
Subject: [PATCH 04/10] phy: dphy: Add configuration helpers
In-Reply-To: <1923627.Ifno3EcWVN@avalon>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <3617916.Vq2Smf1hnZ@avalon> <20180907133739.6lvlw7wsdk4ffeua@flea>
 <1923627.Ifno3EcWVN@avalon>
Message-ID: <20180910141603.gnwpkmemevaxbi7b@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 07, 2018 at 05:26:29PM +0300, Laurent Pinchart wrote:
> > >> + */
> > >> +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> > >> +				     unsigned int bpp,
> > >> +				     unsigned int lanes,
> > >> +				     struct phy_configure_opts_mipi_dphy *cfg)
> > >> +{
> > >> +	unsigned long hs_clk_rate;
> > >> +	unsigned long ui;
> > >> +
> > >> +	if (!cfg)
> > >> +		return -EINVAL;
> > > 
> > > Should we really expect cfg to be NULL ?
> > 
> > It avoids a kernel panic and it's not in a hot patch, so I'd say yes?
> 
> A few line below you divide by the lanes parameter without checking whether it 
> is equal to 0 first, which would also cause issues.

You say that like it would be a bad thing to test for this.

> I believe that invalid values in input parameters should only be handled 
> explicitly when considered acceptable for the caller to pass such values. In 
> this case a NULL cfg pointer is a bug in the caller, which would get noticed 
> during development if the kernel panics.

In the common case, yes. In the case where that pointer is actually
being lost by the caller somewhere down the line and you have to wait
for a while before it happens, then having the driver inoperant
instead of just having a panic seems like the right thing to do.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180910/f063ef39/attachment.sig>
