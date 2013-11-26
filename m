From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 26 Nov 2013 10:25:26 +0100
Subject: [RESEND PATCH v3 3/4] usb: musb: dsps, debugfs files
In-Reply-To: <20131125155739.GF18046@saruman.home>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-4-git-send-email-mpa@pengutronix.de>
 <20131125155739.GF18046@saruman.home>
Message-ID: <20131126092526.GA13532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 09:57:39AM -0600, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 18, 2013 at 04:54:37PM +0100, Markus Pargmann wrote:
> > @@ -350,6 +373,30 @@ out:
> >  	return ret;
> >  }
> >  
> > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> > +{
> > +	struct dentry *root;
> > +	struct dentry *file;
> > +	char buf[128];
> > +
> > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> 
> why ? just use the glue's device

I used this to have a more obvious relationship between musb-core
debugfs and musb-dsps debugfs. Otherwise we would have '47401400.usb'
for dsps and 'musb-hdrc.0.auto' for musb core.

But I can change it if you want.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
