From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 14 Sep 2012 10:41:42 +0200
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
In-Reply-To: <20120914082754.GE3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
Message-ID: <20120914084141.GA2630@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > First, I'd like to have this patch squashed with "i2c: nomadik: Add
> > Device Tree support to the Nomadik I2C driver". I wanted to do this on
> > my own, but the patches do not apply to 3.6-rc5 (with or without
> > regulator removal patch from Linus)?
> 
> I'm really not keen on squashing all my patches together. They are
> clearly have very different purposes. If you think they are closely
> related, then pull them in sequentially, but please don't squash
> all my work into a single patch for no other reason than convenience.

I can't follow this reasoning. I never asked you to squash all patches,
only those two needed to get proper device tree support. Why would you
want to let the device being detected via DT and not scan the child
nodes immediately?

> > I can also take the I2C related changes to the devicetrees via my tree.
> > This is not uncommon. Some people prefer to do this via their soc-trees,
> > though. I don't care much since this is not really a hard dependency
> > causing build failures or merge conflicts, but just needs a little extra
> > time until the patches are all there...
> 
> It would be better for all the Device Tree changes go in as a single
> patch-set. Again, I don't care where they go, so long as they go in
> together. arm-soc seems like the most generic place for them to be
> pulled into though.

This reasoning I can follow, but how should I know you aimed for that? I
only saw a patch [3/3] in one series making the driver probable via DT
and a patch [12/19] in another series to scan the child nodes. That's
all the infos I got. Some more context would have been helpful. Is there
a branch somewhere with all the things collected?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120914/4b49f0dc/attachment-0001.sig>
