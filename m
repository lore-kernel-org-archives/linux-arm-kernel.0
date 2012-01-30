From: greg@kroah.com (Greg KH)
Date: Mon, 30 Jan 2012 10:34:17 -0800
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <201201301758.24531.arnd@arndb.de>
References: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
 <1327165687-4223-3-git-send-email-lee.jones@linaro.org>
 <20120128010534.GA20581@kroah.com>
 <201201301758.24531.arnd@arndb.de>
Message-ID: <20120130183417.GC20118@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:58:24PM +0000, Arnd Bergmann wrote:
> On Saturday 28 January 2012, Greg KH wrote:
> > On Sat, Jan 21, 2012 at 05:08:03PM +0000, Lee Jones wrote:
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > > index 7be9f79..9aa618a 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -176,6 +176,9 @@ config GENERIC_CPU_DEVICES
> > >  	bool
> > >  	default n
> > >  
> > > +config SOC_BUS
> > > +	bool
> > 
> > That's nice, but you do need some kind of help text here, right?
> 
> Wouldn't hurt, but most silent options have no help text, because that
> would never be visible in the kconfig tools, only in the source code.

Ah, it's being set by others, ok, that's fine.

> > > +static struct ida soc_ida;
> > > +static spinlock_t soc_lock;
> > > +
> > > +static ssize_t soc_info_get(struct device *dev,
> > > +			    struct device_attribute *attr,
> > > +			    char *buf);
> > > +
> > 
> > Why not put the whole function here, well a few lines lower, so no
> > forward declaration is needed, saving a few extra lines.
> 
> You made the same comment in a previous review round and then agreed
> that it's correct after all. A small comment why the forward declaration
> is required here would probably be appropriate here, otherwise the
> next person reading this would have the same thought.

Heh, at least I'm consistant with my requests :)

And yes, you are right, this is fine, a small comment would be good to
have so that I don't make the same review comment the next time around.

thanks,

greg k-h
