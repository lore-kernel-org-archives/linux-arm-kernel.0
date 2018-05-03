From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 15:59:04 +0200
Subject: [PATCH v4 6/8] drm/panel: Add Ilitek ILI9881c panel driver
In-Reply-To: <20180426150712.GF31888@ulmo>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
 <a99bb44577ae18e77e60dba904618db23ee5dca7.1522835818.git-series.maxime.ripard@bootlin.com>
 <20180426150712.GF31888@ulmo>
Message-ID: <20180503135904.bxobnijc3qadpz4f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Thanks for your review, I'll fix the other things you pointed out.

On Thu, Apr 26, 2018 at 05:07:12PM +0200, Thierry Reding wrote:
> > +static int ili9881c_send_cmd_data(struct ili9881c *ctx, u8 cmd, u8 data)
> > +{
> > +	u8 buf[2] = { cmd, data };
> > +	int ret;
> > +
> > +	ret = mipi_dsi_dcs_write_buffer(ctx->dsi, buf, sizeof(buf));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> According to this you're sending DCS commands, but none of the above
> look like valid DCS commands. Do you know what's going on here?

It looks to me that they are custom DCS commands.

> Also, can you include a reference to a datasheet where these
> instructions come from?

I'm not sure an Excel spreadsheet coming from the panel supplier would
be a good thing to include in a driver :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/3bd1e737/attachment.sig>
