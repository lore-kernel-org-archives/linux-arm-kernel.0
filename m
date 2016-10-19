From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 19 Oct 2016 04:56:57 +0200
Subject: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
In-Reply-To: <20161019025154.rmw56aoh27wbrene@earth>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <20161019025154.rmw56aoh27wbrene@earth>
Message-ID: <20161019025656.564mntn7mt7ei36m@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 19, 2016 at 04:51:55AM +0200, Sebastian Reichel wrote:
> > diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> > index b1b8658..d35a5fe 100644
> > --- a/drivers/mfd/axp20x-i2c.c
> > +++ b/drivers/mfd/axp20x-i2c.c
> > @@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
> >  
> > -/*
> > - * This is useless for OF-enabled devices, but it is needed by I2C subsystem
> > - */
> >  static const struct i2c_device_id axp20x_i2c_id[] = {
> > +	{ "axp152", 0 },
> > +	{ "axp202", 0 },
> > +	{ "axp209", 0 },
> > +	{ "axp221", 0 },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> 
> Thanks, queued.

My mistake. It should obviously go through mfd. So take this instead:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161019/aa748c19/attachment.sig>
