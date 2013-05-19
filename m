From: romieu@fr.zoreil.com (Francois Romieu)
Date: Sun, 19 May 2013 10:38:22 +0200
Subject: [PATCH] net: dm9000: Allow instantiation using device tree
In-Reply-To: <20130519070538.GX32299@pengutronix.de>
References: <1368918194-24030-1-git-send-email-tomasz.figa@gmail.com>
 <20130519070538.GX32299@pengutronix.de>
Message-ID: <20130519083822.GA31087@electric-eye.fr.zoreil.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> :
[...]
> > +#ifdef CONFIG_OF
> > +static struct dm9000_plat_data *dm9000_parse_dt(struct device *dev)
> > +{
> > +	struct dm9000_plat_data *pdata;
> > +	struct device_node *np = dev->of_node;
> > +	const void *prop;
> > +	int len;
> > +
> > +	if (!np)
> > +		return NULL;
> 
> You should be able to kill the ifdef around this function by doing
> 
> 	if (!IS_ENABLED(CONFIG_OF) || !np)
> 		return NULL;

It will be the first such use of IS_ENABLED in net land.

David, is it ok ?

-- 
Ueimor
