From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Jan 2015 22:30:50 +0100
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <20150119190142.GA9451@kroah.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
Message-ID: <20150119213050.GA32176@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
> >  
> >  static void i2c_adapter_dev_release(struct device *dev)
> >  {
> > -	struct i2c_adapter *adap = to_i2c_adapter(dev);
> > -	complete(&adap->dev_released);
> > +	/* empty, but the driver core insists we need a release function */
> 
> Yeah, it does, but I hate to see this in "real" code as something is
> probably wrong with it if it happens.
> 
> Please move the rest of 'i2c_del_adapter' into the release function
> (what was after the wait_for_completion() call), and then all should be
> fine.

I was about to do this as a follow-up patch. But Russell's and
Lars-Peter's responses made this obsolete already.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/d45fc4fc/attachment-0001.sig>
