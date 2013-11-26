From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Nov 2013 10:40:55 -0600
Subject: [RESEND PATCH v3 3/4] usb: musb: dsps, debugfs files
In-Reply-To: <20131126092526.GA13532@pengutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-4-git-send-email-mpa@pengutronix.de>
 <20131125155739.GF18046@saruman.home>
 <20131126092526.GA13532@pengutronix.de>
Message-ID: <20131126164055.GG24310@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 26, 2013 at 10:25:26AM +0100, Markus Pargmann wrote:
> > On Mon, Nov 18, 2013 at 04:54:37PM +0100, Markus Pargmann wrote:
> > > @@ -350,6 +373,30 @@ out:
> > >  	return ret;
> > >  }
> > >  
> > > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> > > +{
> > > +	struct dentry *root;
> > > +	struct dentry *file;
> > > +	char buf[128];
> > > +
> > > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> > 
> > why ? just use the glue's device
> 
> I used this to have a more obvious relationship between musb-core
> debugfs and musb-dsps debugfs. Otherwise we would have '47401400.usb'
> for dsps and 'musb-hdrc.0.auto' for musb core.
> 
> But I can change it if you want.

yeah, I guess it's best to use the device name on this one, even though
it'll look at bit weird. At least it'll be guaranteed to be unique.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/2f2112b6/attachment.sig>
