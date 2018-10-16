From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 16 Oct 2018 13:09:08 +0200
Subject: [PATCH 1/3] driver core: add probe_err log helper
In-Reply-To: <20181016102715.GD7449@sirena.org.uk>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
 <20181016102715.GD7449@sirena.org.uk>
Message-ID: <20181016110908.GA32581@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 11:27:15AM +0100, Mark Brown wrote:
> On Tue, Oct 16, 2018 at 09:22:42AM +0200, Andrzej Hajda wrote:
> 
> > +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> 
> ...
> 
> > +	return err;
> > +}
> > +
> 
> This will need an EXPORT_SYMBOL for modules won't it?

EXPORT_SYMBOL_GPL() to be specific, as it is dealing with the driver
core.

thanks,

greg k-h
