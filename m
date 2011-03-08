From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Mar 2011 14:24:00 +0100
Subject: [PATCH v9 1/1] PRUSS UIO driver support
In-Reply-To: <alpine.LFD.2.00.1103081133510.2787@localhost6.localdomain6>
References: <1299175677-17859-1-git-send-email-pratheesh@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C008B02@dbde02.ent.ti.com>
	<alpine.LFD.2.00.1103081133510.2787@localhost6.localdomain6>
Message-ID: <201103081424.01476.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 March 2011, Thomas Gleixner wrote:
> > 
> > +static irqreturn_t pruss_handler(int irq, struct uio_info *info) {
> > +     struct pruss_priv *priv = info->priv;
> > +     struct uio_pruss_dev *gdev = priv->pupdev;
> > 
> > Note that info is a pointer to array supporting 8 interrupts. This allows to
> > redirect to driver structure via info->priv quickly.
> 
> struct uio_pruss_dev *dev = container_of(info, struct uio_pruss_dev, info);
> 
> Perhaps ?

That would require having the same number of uio_info structs as uio_pruss_dev
instances. Right now, one platform device has one uio_pruss_dev instance, which
has 8 uio_info instances, so the container_of() trick doesn't work.

	Arnd
